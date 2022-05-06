import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ihliv/base/utils/assets_utils.dart';
import 'package:ihliv/core/network/upload_services.dart';
import 'package:ihliv/sections/main/models/user_model.dart';
import 'package:ihliv/sections/main/pages/root_page.dart';
import 'package:ihliv/services/user_services.dart';

class OauthEditController extends GetxController {
  final nicknameController = TextEditingController();
  final codeController = TextEditingController();

  File? choiceAvatarFile;
  String choiceAssetsAvatar = 'assets/avatars/male_1.png';
  final List<String> _optionAssetsAvatars = [
    'assets/avatars/male_1.png',
    'assets/avatars/male_2.png',
    'assets/avatars/male_3.png',
    'assets/avatars/female_1.png',
    'assets/avatars/female_2.png',
    'assets/avatars/female_3.png',
  ];

  List<String> genderAvatars = [];

  UserModel? user = UserServices.instance.user;
  String? country;
  String? birthday;
  String? language;
  String gender = "Male";

  @override
  void onReady() {
    birthday = "1995-01-01";
    genderAvatars = _optionAssetsAvatars.sublist(0, 3);
    update();
    super.onReady();
  }

  Future submit() async {
    if (choiceAvatarFile == null && choiceAssetsAvatar.isEmpty) {
      EasyLoading.showToast("Please select or upload an avatar");
      return;
    }
    if (nicknameController.text.isEmpty) {
      EasyLoading.showToast("Please enter nickname");
      return;
    }
    if (gender.isEmpty) {
      EasyLoading.showToast("Please select gender");
      return;
    }
    if (birthday == null || birthday!.isEmpty) {
      EasyLoading.showToast("Please select your date of birth");
      return;
    }
    if (country == null || country!.isEmpty) {
      EasyLoading.showToast("Please select country");
      return;
    }
    if (language == null || language!.isEmpty) {
      EasyLoading.showToast("Please select language");
      return;
    }

    File avatarFile;
    if (choiceAvatarFile != null) {
      avatarFile = choiceAvatarFile!;
    } else {
      avatarFile = await AssetsUtils.imageToFile(choiceAssetsAvatar);
    }
    try {
      EasyLoading.show();
      final uploadImage = await UploadServices.instance.uploadFile(avatarFile);
      await UserServices.instance.updateUserAvatar(uploadImage?.filename ?? '');
      await UserServices.instance.updateUserBase(nickname: nicknameController.text,
          country: country,
          birthday: birthday,
          gender: gender == "Male" ? "1": "2",
          invitationCode: codeController.text);
      await UserServices.instance.updateUserInfo(language: language, nickname: nicknameController.text);
      Get.offAll(() => RootPage());
    } catch (e) {
      EasyLoading.showToast(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  skip() async {
    try {
      EasyLoading.show();
      await UserServices.instance.updateUserBase(
        country: 'USA',
        gender: '1',
        invitationCode: codeController.text,
        birthday: birthday,
      );
      Get.offAll(() => RootPage());
    } on DioError catch (e) {
      EasyLoading.showToast(e.error.getMessage());
    } finally {
      EasyLoading.dismiss();
    }
  }

  choiceImage() {
    // try {
    //   EasyLoading.show();
    //   final imagePath = await MediaServices.instance.pickImage(imageQuality: 70);
    //   choiceAvatarFile = await MediaServices.instance.cropImage(imagePath!);
    //   choiceAssetsAvatar = '';
    //   update();
    // } on PlatformException catch (e) {
    //   EasyLoading.dismiss();
    //   if (e.code == "photo_access_denied") {
    //     MediaServices.instance.guideAuth();
    //   }
    // } catch (e) {
    //   EasyLoading.showToast(e.toString());
    // } finally {
    //   EasyLoading.dismiss();
    // }
  }

  void choiceAssets(String avatarAsset, bool value) {
    choiceAssetsAvatar = value ? avatarAsset : '';
    choiceAvatarFile = null;
    update();
  }

  void choiceValue({String? country, String? language, String? gender, String? birthday}) {
    if (country != null) {
      this.country = country;
    }
    if (language != null) {
      this.language = language;
    }
    if (birthday != null) {
      this.birthday = birthday;
    }
    if (gender != null) {
      this.gender = gender;
      if (gender == 'Male') {
        genderAvatars = _optionAssetsAvatars.sublist(0, 3);
      } else {
        genderAvatars = _optionAssetsAvatars.sublist(3, 6);
      }
    }
    update();
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
