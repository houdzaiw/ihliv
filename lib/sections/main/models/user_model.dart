import 'package:collection/collection.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ihliv/base/utils/hex_color.dart';

enum UserStatus { Online, InCall, Busy, Offline, NotAvailable }

extension UserStateExtension on UserStatus {
  static UserStatus? fromValue(String? value) {
    if (value == null) return null;
    switch (value) {
      case "Online": return UserStatus.Online;
      case "InCall": return UserStatus.InCall;
      case "Busy": return UserStatus.Busy;
      case "Offline": return UserStatus.Offline;
      case "NotAvailable": return UserStatus.NotAvailable;
    }
    return null;
  }
  String get value {
    switch (this) {
      case UserStatus.Online:
        return "Online";
      case UserStatus.InCall:
        return "InCall";
      case UserStatus.Busy:
        return "Busy";
      case UserStatus.Offline:
        return "Offline";
      case UserStatus.NotAvailable:
        return "Offline";
    }
  }
  Color get statusColor {
    switch (this) {
      case UserStatus.Online:
        return HexColor.fromHex("#7CF7A3");
      case UserStatus.InCall:
        return HexColor.fromHex("#FF4768");
      case UserStatus.Busy:
        return HexColor.fromHex("#FAB96F");
      case UserStatus.Offline:
        return HexColor.fromHex("#D6D6D6");
      case UserStatus.NotAvailable:
        return HexColor.fromHex("#D6D6D6");
    }
  }

  Color get callColor {
    switch (this) {
      case UserStatus.Online:
        return HexColor.fromHex("#6C6FFF");
      case UserStatus.InCall:
      case UserStatus.Busy:
      case UserStatus.Offline:
      case UserStatus.NotAvailable:
        return HexColor.fromHex("#D6D6D6");
    }
  }

  bool get canCall {
    switch (this) {
      case UserStatus.Online:
        return true;
      case UserStatus.InCall:
      case UserStatus.Busy:
      case UserStatus.Offline:
      case UserStatus.NotAvailable:
        return false;
    }
  }
}

class UserModel {
  int? auditStatus;
  int? availableCoins;
  String? avatar;
  String? avatarMiddleThumbUrl;
  String? avatarThumbUrl;
  String? avatarUrl;
  String? birthday;
  String? country;
  int? followNum;
  int? gender;
  bool? isAnswer;
  bool? isBlock;
  bool? isHavePassword;
  bool? isInternal;
  bool? isRecharge;
  bool? isSwitchNotDisturbCall;
  bool? isSwitchNotDisturbIm;
  bool? isVip;
  int? level;
  String? nickname;
  int? praiseNum;
  String? rongcloudToken;
  List<UserTagDetails>? tagDetails;
  List<String>? tagsList;
  String? userId;
  String? broadcasterId;
  int? userType;

  int? age;
  String? language;
  List<UserMediaItemModel>? mediaList;
  List<UserMediaItemModel>? videoPaths;
  bool? isClub;
  String? about;
  int? unitPrice;
  int? grade;
  int? vipUnitPrice;
  bool? acceptMultipleCall;
  bool? isProbationPeriod;
  String? avatarMapPath;
  UserStatus? status;
  int? callCoins;
  String? unit;
  List<String>? videoMapPaths;
  bool? isMultiple;
  List<String>? applicableTags;
  List<String>? labelsList;
  List<String>? giftList;

  UserModel({
    this.auditStatus,
    this.availableCoins,
    this.avatar,
    this.avatarMiddleThumbUrl,
    this.avatarThumbUrl,
    this.avatarUrl,
    this.birthday,
    this.country,
    this.followNum,
    this.gender,
    this.isAnswer,
    this.isBlock,
    this.isHavePassword,
    this.isInternal,
    this.isRecharge,
    this.isSwitchNotDisturbCall,
    this.isSwitchNotDisturbIm,
    this.isVip,
    this.level,
    this.nickname,
    this.praiseNum,
    this.rongcloudToken,
    this.tagDetails,
    this.tagsList,
    this.userId,
    this.userType,
    this.age,
    this.language,
    this.mediaList,
    this.isClub,
    this.about,
    this.unitPrice,
    this.grade,
    this.vipUnitPrice,
    this.acceptMultipleCall,
    this.isProbationPeriod,
    this.avatarMapPath,
    this.status,
    this.callCoins,
    this.unit,
    this.videoMapPaths,
    this.videoPaths,
    this.isMultiple,
    this.applicableTags,
    this.labelsList,
    this.giftList,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    auditStatus = json['auditStatus'];
    availableCoins = json['availableCoins'];
    avatar = json['avatar'];
    avatarMiddleThumbUrl = json['avatarMiddleThumbUrl'];
    avatarThumbUrl = json['avatarThumbUrl'];
    avatarUrl = json['avatarUrl'];
    birthday = json['birthday'];
    country = json['country'];
    followNum = json['followNum'];
    gender = json['gender'];
    isAnswer = json['isAnswer'];
    isBlock = json['isBlock'];
    isHavePassword = json['isHavePassword'];
    isInternal = json['isInternal'];
    isRecharge = json['isRecharge'];
    isSwitchNotDisturbCall = json['isSwitchNotDisturbCall'];
    isSwitchNotDisturbIm = json['isSwitchNotDisturbIm'];
    isVip = json['isVip'];
    level = json['level'];
    nickname = json['nickname'];
    praiseNum = json['praiseNum'];
    rongcloudToken = json['rongcloudToken'];
    if (json['tagDetails'] != null) {
      tagDetails = <UserTagDetails>[];
      json['tagDetails'].forEach((v) {
        tagDetails!.add(UserTagDetails.fromJson(v));
      });
    }

    if (json['tagsList'] != null) {
      tagsList = json['tagsList'].cast<String>();
    }
    userId = json['userId'];
    broadcasterId = json['broadcasterId'];
    userType = json['userType'];

    age = json['age'];
    language = json['language'];
    if (json['mediaList'] != null) {
      mediaList = <UserMediaItemModel>[];
      json['mediaList'].forEach((v) {
        mediaList!.add(UserMediaItemModel.fromJson(v));
      });
    }
    if (json['videoPaths'] != null) {
      videoPaths = <UserMediaItemModel>[];
      json['videoPaths'].forEach((v) {
        videoPaths!.add(UserMediaItemModel.fromJson(v));
      });
    }
    isClub = json['isClub'];
    about = json['about'];
    unitPrice = json['unitPrice'];
    grade = json['grade'];
    vipUnitPrice = json['vipUnitPrice'];
    acceptMultipleCall = json['acceptMultipleCall'];
    isProbationPeriod = json['isProbationPeriod'];
    avatarMapPath = json['avatarMapPath'];
    if (json['status'] != null) {
      final statusStr = (json['status'] as String).replaceAll(' ', '');
      status = EnumToString.fromString(UserStatus.values, statusStr);
    }

    callCoins = json['callCoins'];
    unit = json['unit'];
    if (json['videoMapPaths'] != null) {
      videoMapPaths = json['videoMapPaths'].cast<String>();
    }
    isMultiple = json['isMultiple'];
    if (json['applicableTags'] != null) {
      applicableTags = json['applicableTags'].cast<String>();
    }
    if (json['labelsList'] != null) {
      labelsList = json['labelsList'].cast<String>();
    }
    if (json['giftList'] != null) {
      giftList = json['giftList'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auditStatus'] = auditStatus;
    data['availableCoins'] = availableCoins;
    data['avatar'] = avatar;
    data['avatarMiddleThumbUrl'] = avatarMiddleThumbUrl;
    data['avatarThumbUrl'] = avatarThumbUrl;
    data['avatarUrl'] = avatarUrl;
    data['birthday'] = birthday;
    data['country'] = country;
    data['followNum'] = followNum;
    data['gender'] = gender;
    data['isAnswer'] = isAnswer;
    data['isBlock'] = isBlock;
    data['isHavePassword'] = isHavePassword;
    data['isInternal'] = isInternal;
    data['isRecharge'] = isRecharge;
    data['isSwitchNotDisturbCall'] = isSwitchNotDisturbCall;
    data['isSwitchNotDisturbIm'] = isSwitchNotDisturbIm;
    data['isVip'] = isVip;
    data['level'] = level;
    data['nickname'] = nickname;
    data['praiseNum'] = praiseNum;
    data['rongcloudToken'] = rongcloudToken;
    if (tagDetails != null) {
      data['tagDetails'] = tagDetails!.map((v) => v.toJson()).toList();
    }
    data['tagsList'] = tagsList;
    data['userId'] = userId;
    data['broadcasterId'] = broadcasterId;
    data['userType'] = userType;

    data['age'] = age;
    data['language'] = language;
    if (mediaList != null) {
      data['mediaList'] = mediaList!.map((v) => v.toJson()).toList();
    }
    if (videoPaths != null) {
      data['videoPaths'] = videoPaths!.map((v) => v.toJson()).toList();
    }
    data['isClub'] = isClub;
    data['about'] = about;
    data['unitPrice'] = unitPrice;
    data['grade'] = grade;
    data['vipUnitPrice'] = vipUnitPrice;
    data['acceptMultipleCall'] = acceptMultipleCall;
    data['isProbationPeriod'] = isProbationPeriod;
    data['avatarMapPath'] = avatarMapPath;
    if (status != null) {
      data['status'] = EnumToString.convertToString(status);
    }
    data['callCoins'] = callCoins;
    data['unit'] = unit;
    data['videoMapPaths'] = videoMapPaths;
    data['isMultiple'] = isMultiple;
    data['applicableTags'] = applicableTags;
    data['labelsList'] = labelsList;
    data['giftList'] = giftList;
    return data;
  }
}

class UserTagDetails {
  String? tag;
  String? tagColor;
  String? tagTip;

  UserTagDetails({this.tag, this.tagColor, this.tagTip});

  UserTagDetails.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    tagColor = json['tagColor'];
    tagTip = json['tagTip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['tagColor'] = tagColor;
    data['tagTip'] = tagTip;
    return data;
  }
}

class UserMediaItemModel {
  String? mediaId;
  String? userId;
  String? mediaType;
  String? mediaPath;
  String? thumbUrl;
  String? mediaUrl;
  int? sort;
  int? coins;

  UserMediaItemModel({this.mediaId, this.userId, this.mediaType, this.mediaPath, this.thumbUrl, this.mediaUrl, this.sort, this.coins});

  UserMediaItemModel.fromJson(Map<String, dynamic> json) {
    mediaId = json['mediaId'];
    userId = json['userId'];
    mediaType = json['mediaType'];
    mediaPath = json['mediaPath'];
    thumbUrl = json['thumbUrl'];
    mediaUrl = json['mediaUrl'];
    sort = json['sort'];
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaId'] = mediaId;
    data['userId'] = userId;
    data['mediaType'] = mediaType;
    data['mediaPath'] = mediaPath;
    data['thumbUrl'] = thumbUrl;
    data['mediaUrl'] = mediaUrl;
    data['sort'] = sort;
    data['coins'] = coins;
    return data;
  }
}

extension UserModelExt on UserModel {
  String? get getAvatar {
    final avatar = this.avatar;
    final avatarUrl = this.avatarUrl;
    return [avatar, avatarUrl].firstWhereOrNull((element) => element != null && element.startsWith("http"));
  }
}
