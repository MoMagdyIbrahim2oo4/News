import 'package:dio/dio.dart';
import 'package:news/core/network/api_constants.dart';
import 'package:news/core/network/api_key_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioClient {
  static Dio? _dio;
  static Dio? get instance{
    _dio??=_getDio();
    return _dio;
  }

  static Dio _getDio(){
    final dio=Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    dio.interceptors.addAll(
      [
        PrettyDioLogger(requestBody: true,responseBody: true),
        ApiKeyInterceptor(),
      ]
    );
    return dio;
  }
}