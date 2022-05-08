import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihliv/sections/anchor/controllers/AnchorController.dart';

class AnchorPage extends StatelessWidget {
  final controller = Get.put(AnchorController());

  AnchorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AnchorController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Text("mine_page"),
          ),
        );
      }),
    );
  }
}