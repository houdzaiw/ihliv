

import 'package:ihliv/sections/main/models/user_model.dart';

class OauthModel {
  bool? isFirstRegister;
  String? token;
  UserModel? userInfo;

  OauthModel({this.isFirstRegister, this.token, this.userInfo});

  OauthModel.fromJson(Map<String, dynamic> json) {
    isFirstRegister = json['isFirstRegister'];
    token = json['token'];
    userInfo = json['userInfo'] != null
        ? UserModel.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFirstRegister'] = isFirstRegister;
    data['token'] = token;
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    return data;
  }
}


