import 'dart:async';
import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ihliv/base/app_routers.dart';
import 'package:ihliv/core/network/http_apis.dart';
import 'package:ihliv/core/network/http_services.dart';
import 'package:ihliv/sections/anchor/pages/anchor_page.dart';
import 'package:ihliv/sections/message/pages/message_page.dart';
import 'package:ihliv/sections/mine/pages/mine_page.dart';
import 'package:ihliv/services/app_services.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

enum HomePageType {
  wall,
  messages,
  mine,
  styles,
  types,
  story,
}

class BarItem {
  HomePageType tag;
  String iconName;
  String activeIconName;
  Widget widget;
  int? badge;

  BarItem({required this.tag, required this.iconName, required this.activeIconName, required this.widget, this.badge});
}

class RootController extends GetxController {
  List<BarItem> items = [];

  StreamSubscription? _unReadCountChangeSub;

  StreamSubscription? _userCoinsSub;
  StreamSubscription? _promotionSub;
  int index = 0;

  @override
  void onReady() async {
    // socket 消息注册
    // SocketServices.instance.register();
    // // socket 消息处理器注册
    // SocketServices.instance.addTaskHandler(LiveCallTaskHandler.instance);
    // SocketServices.instance.addTaskHandler(WalletTaskHandler.instance);
    // // 融云链接
    // IMServices.instance.connect();

    try {
      // UserServices.instance.refreshUserInfo();
      // UserServices.instance.fetchUserFollowList();
      // UserServices.instance.fetchUserBlockedList();
      // await AppServices.instance.fetchAppStrategy();
      await AppServices.instance.fetchAppConfig();
    } on DioError catch (e) {
      EasyLoading.showToast(e.error.getMessage());
      // if (e.error.getCode() == ResponseException.otherDeviceLogin.code) {
      //   _otherDeviceLoginAlert(Get.context!);
      // }
    } finally {
      // AppStrategyModel? model = AppServices.instance.appStrategySub.valueOrNull;
      // index = model?.initTab ?? 0;
      items = [
        BarItem(tag: HomePageType.wall, iconName: 'assets/images/tab_wall_nor.png', activeIconName: 'assets/images/tab_wall_sel.png', widget: AnchorPage()),
        BarItem(tag: HomePageType.messages, iconName: 'assets/images/tab_msg_nor.png', activeIconName: 'assets/images/tab_msg_sel.png', widget: MessagePage()),
        BarItem(tag: HomePageType.mine, iconName: 'assets/images/tab_mine_nor.png', activeIconName: 'assets/images/tab_mine_sel.png', widget: MinePage()),
      ];
      update();
    }
    // IMServices.instance.refreshUnreadCount();
    super.onReady();
  }

  void onSelected(int value) {
    if (index == value) return;
    index = value;
    // IMServices.instance.refreshUnreadCount();
    update();
    AppServices.instance.tabSwitchSub.add(
        items.map((e) => e.widget).toList()[index].toString());
  }

  _otherDeviceLoginAlert(BuildContext context) async {
    final result = await showAlertDialog(
      context: context,
      title: "Login Invalid",
      message: "Current account is logged in on another device.",
      actions: [
        const AlertDialogAction(
            key: "Confirm", isDestructiveAction: true, label: "Confirm"),
      ],
    );
    if (result == "Confirm") {
      // UserServices.instance.logout();
      RongIMClient.disconnect(false);
      Get.offAllNamed(AppPages.oauth);
    }


    @override
    void onClose() {
      _unReadCountChangeSub?.cancel();
      _userCoinsSub?.cancel();
      _promotionSub?.cancel();
      _userCoinsSub?.cancel();
      super.onClose();
    }
  }
}
