import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ihliv/services/app_services.dart';
// import 'package:ihliv/cores/services/app_services.dart';

import 'http_interceptors.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();

  Http._internal() {
    // 基础公参
    dio = Dio();

    // 添加拦截器
    dio.interceptors.addAll([
      RequestInterceptor(),
      ResponseInterceptor(),
    ]);
  }

  void init({String? baseUrl, int connectTimeout = 15000, int receiveTimeout = 15000, Map<String, String>? headers, List<Interceptor>? interceptors}) {
    dio.options = dio.options.copyWith(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, headers: headers ?? const {});
    dio.options.responseType = ResponseType.json;
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  Options makeOptions() {
    Options requestOptions = Options(headers: AppServices.instance.makeCommonParams());
    return requestOptions;
  }

  Future get(String path, {Map<String, dynamic>? params}) async {
    var response = await dio.get(path, queryParameters: params, options: makeOptions(), cancelToken: _cancelToken);
    return response.data["data"];
  }

  Future post(String path, {Map<String, dynamic>? params, data}) async {
    var response = await dio.post(path, data: data, queryParameters: params, options: makeOptions(), cancelToken: _cancelToken);
    return response.data["data"];
  }

  Future upload(String path, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName, contentType: MediaType.parse("image/jpg")),
    });
    var response = await dio.put(path, data: formData, options: makeOptions(), cancelToken: _cancelToken);
    return response.data["data"];
  }
}

class HttpUtils {
  static void init({required String baseUrl, int connectTimeout = 15000, int receiveTimeout = 15000, List<Interceptor>? interceptors}) {
    Http().init(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, interceptors: interceptors);
  }

  static void cancelRequests({required CancelToken token}) {
    Http().cancelRequests(token: token);
  }

  static Future get(String path, {Map<String, dynamic>? params}) async {
    return await Http().get(path, params: params);
  }

  static Future post(String path, {data, Map<String, dynamic>? params}) async {
    return await Http().post(path, data: data, params: params);
  }

  static Future upload(String path, File? file) async {
    if (file == null) {
      return;
    }
    return await Http().upload(path, file);
  }
}
