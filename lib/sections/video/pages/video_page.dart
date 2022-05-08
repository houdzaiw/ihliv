import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihliv/sections/mine/controllers/MineController.dart';
import 'package:ihliv/sections/video/controllers/VideoController.dart';

class VideoPage extends StatelessWidget {
  final controller = Get.put(MineController());

  VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<VideoController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Text("video_page"),
          ),
        );
      }),
    );
  }
}