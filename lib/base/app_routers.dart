
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ihliv/sections/main/pages/guide_page.dart';
import 'package:ihliv/sections/main/pages/root_page.dart';

class AppPages {
  static const oauth = "/login";
  static const guide = '/guide';
  static const root = '/root';
  static final routers = [
    // GetPage(name: oauth, page: () => OauthPage()),
    GetPage(name: guide, page: () => GuidePage()),
    GetPage(name: root, page: () => RootPage()),
  ];
}