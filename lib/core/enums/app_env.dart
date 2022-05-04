
enum AppEnv { test, prod }

extension AppEnvExtension on AppEnv {
  baseUrl() {
    switch (this) {
      case AppEnv.test: return "http://192.168.1.110:8001";
      case AppEnv.prod: return "http://api.hiliv.live";
    }
  }

  socketHost() {
    switch (this) {
      case AppEnv.test: return "http://test-im.iohubonline.club/";
      case AppEnv.prod: return "appsocket.hiliv.live";
    }
  }
}