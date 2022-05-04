import 'package:flutter/material.dart';
import 'package:ihliv/base/utils/hex_color.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/nodata.png'),
        Container(height: 20),
        Text('No Data', style: TextStyle(color: HexColor.fromHex("#CFCFCF"), fontSize: 20, fontWeight: FontWeight.bold))
      ],
    );
  }
}

class ErrorAvatarWidget extends StatelessWidget {
  const ErrorAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/default_avatar.png", fit: BoxFit.contain);
  }
}
