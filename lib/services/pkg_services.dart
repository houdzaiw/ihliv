import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:ihliv/base/custom_style.dart';
// import 'package:ihliv/pubic/custom_style.dart';
import 'package:in_app_review/in_app_review.dart';
// import 'package:ihliv/cores/custom_style.dart';
// import 'package:ihliv/cores/services/app_services.dart';
// import 'package:ihliv/cores/services/hive_services.dart';
import 'package:ihliv/main.dart';
import 'package:package_info/package_info.dart';

import 'app_services.dart';
import 'hive_services.dart';

class SystemInfo {
  final String language;
  SystemInfo(this.language);
}

class PkgServices {
  PkgServices._privateConstructor();

  static final PkgServices instance = PkgServices._privateConstructor();

  InAppReview inAppReview = InAppReview.instance;
  PackageInfo? packageInfo;
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;
  SystemInfo? systemInfo;
  String? countryCode;
  String? uuid;

  Future<void> buildInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
    }

    packageInfo = await PackageInfo.fromPlatform();
    systemInfo = SystemInfo(Platform.localeName);

    if (const bool.fromEnvironment("dart.vm.product")) {
      // 永久有效
      uuid = await FlutterUdid.udid;
    } else {
      // 卸载变更
      if (Platform.isIOS) {
        uuid = iosDeviceInfo?.identifierForVendor;
      } else {
        uuid = androidDeviceInfo?.id;
      }
    }
    logger.d('uuid: $uuid');
  }

  // 商店评分
  requestReview() async {
    // 只评价一次
    final isStoreReview = HiveServices.instance.simpleBox.get("store_review");
    if (isStoreReview != null) return;
    HiveServices.instance.simpleBox.put("store_review", true);

    // 审核不评价
    // if (AppServices.instance.isReview) return;

    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text("Five-Star Praise", style: Theme.of(context).textTheme.black(16)),
          message: Text(
            "Do you like ${packageInfo?.appName ?? ""}\n Please rate a five star or give a feedback to us",
            // textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.black99(14),
          ),
          actions: [
            CupertinoActionSheetAction(
              child: const Text("Praise"),
              onPressed: () async {
                Get.back();
                if (await inAppReview.isAvailable()) {
                  inAppReview.requestReview();
                }
              },
            ),
            CupertinoActionSheetAction(
              child: const Text("Negative"),
              onPressed: () => Get.back(),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("Cancel"),
            isDefaultAction: true,
            onPressed: (() {
              Get.back();
            }),
          ),
        );
      },
    );
  }

  // 打开次数检查
  bool firstOpen() {
    final isFirstOpen = HiveServices.instance.simpleBox.get("firstOpen");
    if (isFirstOpen == null) {
      HiveServices.instance.simpleBox.put("firstOpen", false);
      return true;
    }
    return false;
  }
}
