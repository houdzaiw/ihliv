
import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {


  HiveServices._privateConstructor();
  static final HiveServices instance = HiveServices._privateConstructor();
  late Box simpleBox;
  late Box hostBox;
  late Box followedBox;
  late Box blockedBox;
  late Box callBox;
  late Box productBox;
  late Box translateBox;
  late Box orderBox;

  register() async {
    await Hive.initFlutter();
    // 单一对象储存
    simpleBox = await Hive.openBox('simple');
    // 主播储存
    hostBox = await Hive.openBox('host');
    followedBox = await Hive.openBox('followed');
    blockedBox = await Hive.openBox('blocked');
    // 呼叫记录储存
    callBox = await Hive.openBox('call');
    // 商品
    productBox = await Hive.openBox('product');
    // 翻译
    translateBox = await Hive.openBox('translate');
    // 订单（未消费订单、验证失败订单）
    orderBox = await Hive.openBox('order');
  }
}