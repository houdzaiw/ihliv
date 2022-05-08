import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihliv/sections/message/controllers/MessageController.dart';

class MessagePage extends StatelessWidget {
  final controller = Get.put(MessageController());

  MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<MessageController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Text("anchor_page"),
          ),
        );
      }),
    );
  }
}