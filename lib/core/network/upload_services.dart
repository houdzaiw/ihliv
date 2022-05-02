import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ihliv/base/oss_policy_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:ihliv/base/upload_result_model.dart';
import 'package:ihliv/core/network/http_apis.dart';
import 'package:ihliv/core/network/http_services.dart';
import 'package:ihliv/main.dart';
import 'package:http_parser/http_parser.dart';

class UploadServices {
  UploadServices._privateConstructor();

  static final UploadServices instance = UploadServices._privateConstructor();

  Future<UploadResultModel?> uploadFile(File file) async {
    try {
      final res = await HttpUtils.get(HttpApis.getOssPolicy);
      final policy = OSSPolicyModel.fromJson(res);

      final fileName = DateTime.now().millisecondsSinceEpoch.toString() + "." + file.path.split('.').last;
      final fileKey = (policy.dir ?? "") + fileName;

      final dio = Dio();
      FormData formData = FormData.fromMap({
        "ossaccessKeyId": policy.accessKeyId,
        "policy": policy.policy,
        "signature": policy.signature,
        "callback": policy.callback,
        "key": fileKey,
        "file": MultipartFile.fromBytes(file.readAsBytesSync(), filename: fileName, contentType: MediaType.parse(mime(fileName)!))
      });
      final response = await dio.post(policy.host ?? '', data: formData);
      return UploadResultModel.fromJson(response.data['data']);
    } catch (e) {
      logger.e(e.toString());
    }
    return null;
  }
}
