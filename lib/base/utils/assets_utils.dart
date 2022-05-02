import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AssetsUtils {
  static Future<File> imageToFile(String imagePath) async {
    final filename = imagePath.split('/').last;
    var bytes = await rootBundle.load(imagePath);
    return await FileUtils.writeFile(bytes, filename);
  }
}

class FileUtils {
  // 将data写入文件
  static Future<File> writeFile(ByteData data, String filename) async {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$filename');
    await file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return file;
  }
}
