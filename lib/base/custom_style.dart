import 'package:flutter/material.dart';
import 'package:ihliv/base/utils/hex_color.dart';
// import 'package:ihliv/pubic/utils/hex_color.dart';

extension CustomStyles on TextTheme {
  TextStyle get loginButton => const TextStyle(inherit: false, fontSize: 50 * 0.43, color: Colors.black, fontFamily: '.SF Pro Text', letterSpacing: -0.41);

  TextStyle black(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#46475B"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.bold);
  }

  TextStyle blackBold33(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#333333"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.bold);
  }

  TextStyle black33(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#333333"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }

  TextStyle black66(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#666666"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }

  TextStyle black99(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#999999"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }

  TextStyle greyBold(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#ADADAF"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.bold);
  }

  TextStyle grey(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#ADADAF"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }

  TextStyle whiteBold(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#FFFFFF"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.bold);
  }

  TextStyle white(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#FFFFFF"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }

  TextStyle greyCC(double fontSize) {
    return TextStyle(fontSize: fontSize, color: HexColor.fromHex("#FFFFFF"), fontFamily: '.SF Pro Text', fontWeight: FontWeight.normal);
  }
}

extension CustomColor on ColorScheme {
  Color get themeRed => HexColor.fromHex("#FF5C9D");
  Color get themeBlue => HexColor.fromHex("#6C6FFF");

  Color get black => HexColor.fromHex("#46475B");
  Color get black33 => HexColor.fromHex("#333333");
  Color get black66 => HexColor.fromHex("#666666");
  Color get black99 => HexColor.fromHex("#999999");
  Color get greyCC => HexColor.fromHex("#CCCCCC");
  Color get greyEE => HexColor.fromHex("#EEEEEE");
  Color get dividing => HexColor.fromHex("#EDEDED");
  Color get grey => HexColor.fromHex("#ADADAF");

  Color get coinsBgBegin => HexColor.fromHex("#FFB13D");
  Color get coinsBgEnd => HexColor.fromHex("#FFB13D");

}

