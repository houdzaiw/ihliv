import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ihliv/main.dart';

import 'http_exceptions.dart';

enum ResponseException {
  otherDeviceLogin
}

extension ResponseExceptionExt on ResponseException {
  int get code {
    switch (this) {
      case ResponseException.otherDeviceLogin: return  10010304;
    }
  }
}

/// 请求拦截
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 日志打印
    var logStr = "😏😏😏😏 Request \n";
    logStr += "url:     ${options.method} ${options.uri}\n";
    logStr += "headers: ${json.encode(options.headers)}\n";
    try {
      logStr += "body:    ${json.encode(options.data)}";
    } catch (_) {}
    logger.d(logStr);
    return handler.next(options);
  }
}

/// 响应拦截
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is String) {
      response.data = json.decode(response.data);
    }
    // 服务器异常拦截
    if (response.data["code"] != 0) {
      final err = DioError(requestOptions: response.requestOptions, response: response, type: DioErrorType.other);
      err.error = BizException(response.data["code"], response.data["msg"]);
      final handle = ErrorInterceptorHandler();
      onError(err, handle);
      handler.reject(err);
      return;
    }

    // 日志打印
    var logStr = "🤓🤓🤓🤓 Response Success\n";
    logStr += "url:     ${response.requestOptions.method} ${response.requestOptions.uri}\n";
    logStr += "headers: ${json.encode(response.requestOptions.headers)}\n";
    try {
      logStr += "body:    ${response.requestOptions.data}\n";
    } catch (_) {}

    logStr += "response:${json.encode(response.data['data'])}";
    logger.d(logStr);

    return handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    err.error = AppException.create(err);

    // 日志打印
    var logStr = "😱😱😱😱 Response Error \n";
    logStr += "url:     ${err.requestOptions.method} ${err.requestOptions.uri}\n";
    logStr += "headers: ${json.encode(err.requestOptions.headers)}\n";
    try {
      logStr += "body:    ${err.requestOptions.data}\n";
    } catch (e) {}
    logStr += "error:   ${err.error.toString()}";
    logger.e(logStr);

    return handler.next(err);
  }
}
