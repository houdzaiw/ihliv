import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ihliv/base/app_routers.dart';
import 'package:ihliv/base/custom_style.dart';
import 'package:ihliv/core/enums/oauth.dart';
import 'package:ihliv/sections/main/controllers/oauth_controller.dart';
import 'package:ihliv/services/pkg_services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class OauthPage extends StatelessWidget {
  final controller = Get.put(OauthController());

  OauthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OauthController>(builder: (controller) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/login_back.png'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildLogoName(),
              const Spacer(flex: 2),
              _buildLoginButtons(context),
              const Spacer(),
              _buildPolicy(context),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }

  _buildLogoName() {
    return Column(
      children: [
        Image.asset('assets/images/logo.png'),
        const SizedBox(height: 20),
        Text(
          PkgServices.instance.packageInfo?.appName ?? '',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  _buildLoginButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: List.generate(3, (index) {
          if (index == 0 && Platform.isIOS) {
            return SignInWithAppleButton(
              onPressed: () => controller.oauth(OauthType.apple),
              style: SignInWithAppleButtonStyle.white,
              height: 50,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            );
          } else if (index == 1) {
            return const SizedBox(height: 10);
          } else if (index == 2) {
            return GFButton(
              // shape: GFButtonShape.square,
              borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              fullWidthButton: true,
              size: 48,
              icon: Image.asset("assets/images/fast_login.png"),
              color: Colors.white,
              onPressed: () => controller.oauth(OauthType.guest),
              text: "Fast Login",
              textStyle: Theme.of(context).textTheme.loginButton,
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  _buildPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "We will not post anything to your social account.\n", style: Theme.of(context).textTheme.bodySmall),
            TextSpan(text: "By using our App you agree with our ", style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: "Terms & Conditions",
              style: const TextStyle(fontSize: 12, color: Colors.lightBlue),
              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppPages.agreePage, arguments: 'assets/files/term_conditions.html'),
            ),
            TextSpan(text: " and ", style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: "Privacy Policy",
              style: const TextStyle(fontSize: 12, color: Colors.lightBlue),
              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppPages.agreePage, arguments: 'assets/files/privacy_policy.html'),
            ),
          ],
        ),
      ),
    );
  }
}
