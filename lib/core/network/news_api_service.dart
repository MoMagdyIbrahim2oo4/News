import 'package:dio/dio.dart';
import 'package:news/core/network/api_constants.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/core/network/dio_exception_handler.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart';
import 'package:news/data/model/source_response.dart';

class NewsApiService {

  Future<List<Sources>> getSources(String category) async {
    final requestOptions=RequestOptions(path: ApiConstants.sourcesApi);
    try{
      final response = await DioClient.instance!.get(
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

  Future<List<Articles>> getNews(String source,int page) async {
    final requestOptions=RequestOptions(path: ApiConstants.newsApi);
    try{
      final response = await DioClient.instance!.get(
        requestOptions.path,
        queryParameters: {
          ApiConstants.source: source,
          "pageSize":4,
          "page":page
        },
      );
      NewsResponse newsResponse=NewsResponse.fromJson(response.data);
      return newsResponse.articles??[];
    }
    catch(e){
      throw mapDioException(e, requestOptions);
    }
  }

  Future<List<SearchArticles>> search(String q, int page) async {
    if (q.trim().isEmpty) {
      return [];
    }

    final requestOptions = RequestOptions(path: ApiConstants.searchApi);
    try {
      final response = await DioClient.instance!.get(
        requestOptions.path,
        queryParameters: {
          "q": q,
          "pageSize": 4,
          "page": page,
        },
      );
      SearchResponse searchResponse = SearchResponse.fromJson(response.data);
      return searchResponse.articles ?? [];
    } catch (e) {
      throw mapDioException(e, requestOptions);
    }
  }
}
