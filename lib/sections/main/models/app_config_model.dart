
import 'package:enum_to_string/enum_to_string.dart';
import 'package:ihliv/sections/main/models/user_model.dart';

class ServerConfigsGiftModel {
  String? id;
  int? coins;
  String? name;
  String? ll;
  String? ss;
  String? rl;
  String? dy;

  ServerConfigsGiftModel({this.id, this.coins, this.ll, this.ss, this.rl, this.dy});

  ServerConfigsGiftModel.fromJson(dynamic json) {
    id = json['id'];
    coins = json['coins'];
    name = json['name'];
    ll = json['ll'];
    ss = json['ss'];
    rl = json['rl'];
    dy = json['dy'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coins'] = coins;
    map['name'] = name;
    map['ll'] = ll;
    map['ss'] = ss;
    map['rl'] = rl;
    map['dy'] = dy;
    return map;
  }
}
class ServerConfigsTagModel {
  String? name;
  String? sub;

  ServerConfigsTagModel({this.name, this.sub});

  ServerConfigsTagModel.fromJson(dynamic json) {
    name = json['name'];
    sub = json['sub'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['sub'] = sub;
    return map;
  }
}
class ServerConfigsAppConfig {
  int? heartbeat;
  int? heartbeat_interval;
  bool? signInEnable;
  bool? rankingEnable;
  bool? guardianEnable;
  bool? luckyNumberEnable;
  bool? translateEnable;

  ServerConfigsAppConfig({this.heartbeat, this.heartbeat_interval, this.signInEnable, this.rankingEnable, this.guardianEnable, this.luckyNumberEnable, this.translateEnable});

  ServerConfigsAppConfig.fromJson(dynamic json) {
    heartbeat = json['heartbeat'];
    heartbeat_interval = json['heartbeat_interval'];
    signInEnable = json['signInEnable'];
    rankingEnable = json['rankingEnable'];
    guardianEnable = json['guardianEnable'];
    luckyNumberEnable = json['luckyNumberEnable'];
    translateEnable = json['translateEnable'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['heartbeat'] = heartbeat;
    map['heartbeat_interval'] = heartbeat_interval;
    map['signInEnable'] = signInEnable;
    map['rankingEnable'] = rankingEnable;
    map['guardianEnable'] = guardianEnable;
    map['luckyNumberEnable'] = luckyNumberEnable;
    map['translateEnable'] = translateEnable;
    return map;
  }
}
enum ServerConfigsVerState { review, published }
enum ServerConfigsAppDeviceAreaAuth { restricted, authorized }
enum ServerConfigsMaxResolution { c, b }

class AppConfigModel {
  String? ver;
  List<ServerConfigsGiftModel>? gifts;
  List<ServerConfigsTagModel>? tags;
  ServerConfigsAppConfig? config;
  String? status;
  ServerConfigsVerState? statusEnum;
  int? device;
  ServerConfigsAppDeviceAreaAuth? deviceEnum;
  ServerConfigsMaxResolution? max_resolution;
  List<String>? tabs;
  String? system_members;

  AppConfigModel({this.ver, this.gifts, this.tags, this.config, this.status, this.statusEnum});

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    ver = json["ver"];
    gifts = List.of(json["gifts"]).map((i) => ServerConfigsGiftModel.fromJson(i)).toList();
    tags = List.of(json["tags"]).map((i) => ServerConfigsTagModel.fromJson(i)).toList();
    config = json['config'] != null ? ServerConfigsAppConfig.fromJson(json['config']) : null;
    status = json["status"];

  }

  Map<String, dynamic> toJson() {
    return {
      "ver": ver,
      "gifts": gifts?.map((v) => v.toJson()).toList(),
      "tags": gifts?.map((v) => v.toJson()).toList(),
    };
  }
}
