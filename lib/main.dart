import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ihliv/base/app_routers.dart';
import 'package:ihliv/base/custom_style.dart';
import 'package:ihliv/core/enums/app_env.dart';
import 'package:ihliv/services/app_services.dart';
import 'package:ihliv/services/pkg_services.dart';
import 'package:ihliv/services/user_services.dart';
import 'package:logger/logger.dart';

var logger = Logger(level: Level.debug);
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppServices.instance.run(AppEnv.test);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。
    // 写在组件渲染之后，是为了在渲染后进行set赋值,覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFirstOpen = PkgServices.instance.firstOpen();
    final isLogin = UserServices.instance.token?.isNotEmpty ?? false;
    return GetMaterialApp(
      initialRoute: isFirstOpen ? AppPages.guide : (isLogin ? AppPages.root : AppPages.oauth),
      // initialRoute: AppPages.oauth,
      getPages: AppPages.routers,
      builder: EasyLoading.init(),
      theme: ThemeData(
        splashColor: Theme.of(context).colorScheme.themeRed.withOpacity(0.1),
        canvasColor: Colors.white,
        // 页面整体背景色
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.blackBold33(16),
          foregroundColor: Theme.of(context).colorScheme.black33,
          shadowColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}