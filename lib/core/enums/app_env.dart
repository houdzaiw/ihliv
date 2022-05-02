
enum AppEnv { test, prod }

extension AppEnvExtension on AppEnv {
  baseUrl() {
    switch (this) {
      case AppEnv.test: return "http://test-app.iohubonline.club/";
      case AppEnv.prod: return "";
    }
  }

  socketHost() {
    switch (this) {
      case AppEnv.test: return "http://test-im.iohubonline.club/";
      case AppEnv.prod: return "";
    }
  }
}