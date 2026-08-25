import 'package:dio/dio.dart';
import 'package:news/core/network/api_constants.dart';
import 'package:news/core/network/dio_exception_handler.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/source_response.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);

  Future<List<Sources>> getSources(String category) async {
    final requestOptions=RequestOptions(path: ApiConstants.sourcesApi);
    try{
      final response = await dio.get(
        requestOptions.path,
        queryParameters: {ApiConstants.category: category},
      );
      SourceResponse sourceResponse = SourceResponse.fromJson(response.data);
      return sourceResponse.sources ?? [];
    }
    catch(e){
      throw mapDioException(e, requestOptions);
    }
  }

  Future<List<Articles>> getNews(String source) async {
    final requestOptions=RequestOptions(path: ApiConstants.newsApi);
    try{
      final response = await dio.get(
        requestOptions.path,
        queryParameters: {ApiConstants.source: source},
      );
      NewsResponse newsResponse=NewsResponse.fromJson(response.data);
      return newsResponse.articles??[];
    }
    catch(e){
      throw mapDioException(e, requestOptions);
    }
  }
}
