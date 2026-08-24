import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioClient {
  static Dio? _dio;
  static Dio? get instance{
    _dio??=_getDio();
    return _dio;
  }

  static Dio _getDio(){
    final dio=Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));
    dio.interceptors.addAll(
      [
        PrettyDioLogger(requestBody: true,responseBody: true)
      ]
    );
    return dio;
  }
}