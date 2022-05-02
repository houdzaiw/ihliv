// 异常
import 'package:dio/dio.dart';

/// 自定义异常
class AppException implements Exception {
  final String _message;
  final int _code;

  AppException(this._code, this._message);

  @override
  String toString() {
    return "[$_code] $_message";
  }

  String getMessage() {
    return _message;
  }

  int getCode() {
    return _code;
  }

  factory AppException.create(DioError error) {
    if (error.type == DioErrorType.response) {
      int statusCode = error.response?.statusCode ?? 400;
      if (statusCode == 200) {
        // 业务异常
        return BizException(error.response?.data["code"] ?? -1, error.response?.data["msg"] ?? "System error, please try again later");
      } else {
        // 服务器异常
        return UnauthorisedException(statusCode, error.message);
      }
    } else {
      // 请求异常
      try {
        final serverResJson = error.response?.data as Map<String, dynamic>;
        return BizException(serverResJson["code"] ?? -1, serverResJson["msg"] ?? "System error, please try again later");
      } catch (e) {
        return BadRequestException(error.type.index, error.message);
      }
    }
  }
}

/// 请求异常
class BadRequestException extends AppException {
  BadRequestException(int code, String message) : super(code, message);
}

/// 服务器异常
class UnauthorisedException extends AppException {
  UnauthorisedException(int code, String message) : super(code, message);
}

/// 业务异常
class BizException extends AppException {
  BizException(int code, String message) : super(code, message);
}

enum BizExceptions {
  deviceNotSupport,
  invalidToken,
}

const BizExceptionsRawValues = {
  BizExceptions.deviceNotSupport: -99999,
  BizExceptions.invalidToken: -6
};