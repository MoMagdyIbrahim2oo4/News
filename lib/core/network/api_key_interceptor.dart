import 'package:dio/dio.dart';
import 'package:news/core/network/api_constants.dart';

class ApiKeyInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    options.headers['X-Api-Key']=ApiConstants.apiKeyValue;
    handler.next(options);
  }
}