import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ihliv/base/app_routers.dart';
import 'package:ihliv/core/enums/oauth.dart';
import 'package:ihliv/sections/main/models/oauth_model.dart';
import 'package:ihliv/sections/main/pages/oauth_edit_page.dart';
import 'package:ihliv/services/pkg_services.dart';
import 'package:ihliv/services/user_services.dart';
// import 'package:ohliv/cores/app_routers.dart';
// import 'package:ohliv/cores/enums/oauth.dart';
// import 'package:ohliv/modules/root/models/oauth_model.dart';
// import 'package:ohliv/modules/root/pages/oauth_edit_page.dart';
// import 'package:ohliv/cores/services/pkg_services.dart';
// import 'package:ohliv/cores/services/user_services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OauthController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  oauth(OauthType type) async {
    EasyLoading.show();
    try {
      OauthModel? oauthModel;
      String? accessToken;
      if (type == OauthType.guest) {
        accessToken = PkgServices.instance.uuid;
      }
      if (type == OauthType.apple) {
        final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
        accessToken = credential.identityToken;
      }

      oauthModel = await UserServices.instance.oauth(type: type, accessToken: accessToken ?? '');

      if (oauthModel.isFirstRegister ?? false) {
        Get.offAll(() => OauthEditPage());
      } else {
        Get.offAllNamed(AppPages.root);
      }
    } on DioError catch (e) {
      EasyLoading.showToast(e.error.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
