import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ihliv/core/enums/oauth.dart';
import 'package:ihliv/core/enums/update_media_type.dart';
import 'package:ihliv/core/network/http_apis.dart';
import 'package:ihliv/core/network/http_services.dart';
import 'package:ihliv/sections/main/models/oauth_model.dart';
import 'package:ihliv/sections/main/models/user_model.dart';
import 'package:ihliv/services/hive_services.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:rxdart/rxdart.dart';

class UserServices {
  UserServices._privateConstructor();

  static final UserServices instance = UserServices._privateConstructor();

  // 登录信息
  OauthModel? oauthModel;
  final userSub = BehaviorSubject<UserModel?>();
  final coinsSub = BehaviorSubject<int?>();

  // 读取用户信息
  UserModel? get user => oauthModel?.userInfo;

  String? get token => oauthModel?.token;

  String? get userId => oauthModel?.userInfo?.userId;

  int? get userCoins => oauthModel?.userInfo?.availableCoins;

  bool? get userAutoTranslation => HiveServices.instance.simpleBox.get('autoTranslation');

  register() async {
    // 读取用户信息
    final oauthJson = HiveServices.instance.simpleBox.get('oauth');
    if (oauthJson != null) {
      // 登录信息获取
      oauthModel = OauthModel.fromJson(json.decode(oauthJson));
    }
  }

  // 登录
  Future<OauthModel> oauth({required OauthType type, required String accessToken}) async {
    final data = {'oauthType': type.rawValue(), 'token': accessToken};
    final res = await HttpUtils.post(HttpApis.oauth, params: data);
    oauthModel = OauthModel.fromJson(res);
    await refreshUserInfo();
    return oauthModel!;
  }

  // 获取当前用户信息
  Future<UserModel?> refreshUserInfo() async {
    // 获取用户信息
    final res = await HttpUtils.get(HttpApis.getUserInfo, params: {'userId': userId});
    _updateUserCache(UserModel.fromJson(res));
    return oauthModel?.userInfo;
  }

  // 刷新用户金币
  Future<int?> refreshUserCoins() async {
    final res = await HttpUtils.get(HttpApis.getUserCoins);
    updateUserCoins(res['availableCoins']);
    return user?.availableCoins;
  }

  // 更新用户金币，来源有二，1主动通过接口刷新，2长链刷新
  updateUserCoins(int? coins) {
    user?.availableCoins = coins;
    _updateUserCache(user);
  }

  // 更新用户媒体资源
  Future<List<UserMediaItemModel>> updateUserMedia(UpdateUserMediaType type, {String? deleteMediaId, String? mediaPath, String? mediaType}) async {
    Map<String, dynamic> data = {'actionType': type.value};
    if (mediaPath != null) {
      data['mediaPath'] = mediaPath;
    }
    if (mediaType != null) {
      data['mediaType'] = mediaType;
    }
    if (deleteMediaId != null) {
      data['deleteMediaId'] = deleteMediaId;
    }

    final res = await HttpUtils.post(HttpApis.updateUserMedia, data: data);
    return (res as List).map((e) => UserMediaItemModel.fromJson(e)).toList();
  }

  // 更新用户头像
  Future updateUserAvatar(String avatarPath) async {
    final data = {"avatarPath": avatarPath};
    await HttpUtils.post(HttpApis.updateUserAvatar, data: data);
    return;
  }

  // 更新基础信息
  Future updateUserInfo({String? nickname, String? about, String? birthday, String? language}) async {
    final updateInfoMap = {
      "about": about ?? user?.about,
      "birthday": birthday ?? user?.birthday,
      "language": language ?? user?.language ?? 'English',
      "nickname": nickname ?? user?.nickname,
    };
    await HttpUtils.post(HttpApis.updateUserInfo, data: updateInfoMap);
    return;
  }

  // 更新基础信息
  Future updateUserBase({String? nickname, String? country, String? birthday, String? gender, String? invitationCode}) async {
    final updateBaseMap = {
      "birthday": birthday ?? user?.birthday,
      "country": country ?? user?.country,
      "gender": gender ?? user?.gender.toString(),
      "nickname": nickname ?? user?.nickname,
    };
    if (invitationCode != null) {
      updateBaseMap['invitationCode'] = invitationCode;
    }
    await HttpUtils.post(HttpApis.updateUserBaseInfo, data: updateBaseMap);
    return;
  }

  // 更新用户缓存
  _updateUserCache(UserModel? userModel) {
    // 替换本地用户信息
    oauthModel?.userInfo = userModel;
    HiveServices.instance.simpleBox.put('oauth', json.encode(oauthModel?.toJson()));
    // 发送用户信息更新广播
    userSub.add(oauthModel?.userInfo);
    // 发送金币更新广播
    if (coinsSub.valueOrNull != oauthModel?.userInfo?.availableCoins) {
      coinsSub.add(oauthModel?.userInfo?.availableCoins);
    }
  }

  void logout() {
    userSub.add(null);
    HiveServices.instance.simpleBox.delete("oauth");
    HiveServices.instance.followedBox.clear();
    HiveServices.instance.blockedBox.clear();
    HiveServices.instance.productBox.clear();
  }

  // 设置自动翻译
  void setupAutoTranslation(bool value) {
    HiveServices.instance.simpleBox.put('autoTranslation', value);
  }
}
