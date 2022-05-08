import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_instance/src/lifecycle.dart';
import 'package:ihliv/core/enums/app_env.dart';
import 'package:ihliv/core/network/http_apis.dart';
import 'package:ihliv/core/network/http_services.dart';
import 'package:ihliv/sections/main/models/app_config_model.dart';
import 'package:ihliv/services/hive_services.dart';
import 'package:ihliv/services/pkg_services.dart';
// import 'package:ihliv/cores/services/purchase_services.dart';
// import 'package:ihliv/modules/root/models/app_config_model.dart';
// import 'package:ihliv/modules/root/models/app_strategy_model.dart';
// import 'package:ihliv/cores/services/call_services.dart';
// import 'package:ihliv/cores/services/event_services.dart';
// import 'package:ihliv/cores/services/hive_services.dart';
// import 'package:ihliv/cores/services/im_services.dart';
// import 'package:ihliv/cores/services/pkg_services.dart';
// import 'package:ihliv/cores/services/user_services.dart';
import 'package:rxdart/rxdart.dart';

class AppServices extends GetLifeCycle with WidgetsBindingObserver {
  AppServices._privateConstructor();

  static final AppServices instance = AppServices._privateConstructor();

  // 项目运行环境
  AppEnv env = AppEnv.test;

  // app配置信息
  // final appStrategySub = BehaviorSubject<AppStrategyModel>();
  final appConfigSub = BehaviorSubject<AppConfigModel>();

  // 社区发布次数限制
  var storyPublishLimit = 5;

  // 是否审核模式
  // bool get isReview {
    // return appStrategySub.valueOrNull?.isReviewPkg ?? true;
  // }

  // 官方id
  // List<String> get offIds {
  //   List<String> ids = appStrategySub.valueOrNull?.topOfficialUserIds ?? [];
  //   ids.addAll(appStrategySub.valueOrNull?.reviewOfficialBlacklistUserIds ?? []);
  //   ids.addAll(appStrategySub.valueOrNull?.officialBlacklistUserIds ?? []);
  //   return ids;
  // }

  // 客服号
  // String get customServiceNum {
  //   return appStrategySub.valueOrNull?.userServiceAccountId ?? '';
  // }

  // app状态信息
  final appStateSub = PublishSubject<AppLifecycleState>();

  // app tabBar切换信息
  final tabSwitchSub = PublishSubject<String>();


  /// 项目运行入口
  run(AppEnv env) async {
    WidgetsBinding.instance!.addObserver(this);
    this.env = env;

    EasyLoading.instance.loadingStyle = EasyLoadingStyle.dark;
    EasyLoading.instance.toastPosition = EasyLoadingToastPosition.bottom;
    EasyLoading.instance.contentPadding = const EdgeInsets.all(10);
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.offset;
    EasyLoading.instance.radius = 10;

    // 初始化网络请求，配置主地址
    HttpUtils.init(baseUrl: env.baseUrl());
    // 构建包信息
    await PkgServices.instance.buildInfo();
    // 初始化db
    await HiveServices.instance.register();
    // // 注册用户
    // await UserServices.instance.register();
    // // 注册Call服务
    // await CallServices.instance.register();
    // // 注册融云消息服务
    // await IMServices.instance.register();
    // // 注册事件收集
    // EventServices.instance.register();
    // // 注册内购服务
    // PurchaseServices.instance.register();

    refreshStoryPublishLimit();

  }

  // 获取策略
  // Future<AppStrategyModel> fetchAppStrategy() async {
  //   final res = await HttpUtils.get(HttpApis.getAppStrategy);
  //   final model = AppStrategyModel.fromJson(res);
  //   appStrategySub.add(model);
  //   return model;
  // }

  // 获取配置
  Future<AppConfigModel?> fetchAppConfig() async {
    final res = await HttpUtils.get(HttpApis.appInfo, params: {});
    if (res is String && res.isEmpty) return null;
    final model = AppConfigModel.fromJson(json.decode(res));
    appConfigSub.add(model);
    return model;
  }

  refreshStoryPublishLimit() async {
    storyPublishLimit = await HttpUtils.post(HttpApis.storyPublishLimit);
  }

  // 生成公参
  makeCommonParams() {
    var model = '';
    if (Platform.isIOS) {
      model = PkgServices.instance.iosDeviceInfo?.model ?? "";
    }
    if (Platform.isAndroid) {
      model = PkgServices.instance.androidDeviceInfo?.model ?? "";
    }
    Map<String, dynamic> headers = {
      'platform': Platform.isIOS ? 'iOS' : 'Android',
      'is_anchor': false,
      'model': model,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toInt(),
      'device-id': PkgServices.instance.uuid ?? "",
      'pkg': PkgServices.instance.packageInfo?.packageName ?? "",
      'ver': PkgServices.instance.packageInfo?.version ?? "",
      'sys_lan': PkgServices.instance.systemInfo?.language ?? "",
      // 'utm-source': '',
    };

    // if (UserServices.instance.token?.isNotEmpty ?? false) {
    //   headers['Authorization'] = "Bearer ${UserServices.instance.token}";
    // }
    return headers;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    appStateSub.add(state);
  }
}
