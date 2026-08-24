import 'package:dio/dio.dart';
import 'package:news/data/model/source_response.dart';

class NewsApiService {
  final Dio dio;
  NewsApiService(this.dio);
  Future<List<Sources>>getSources(String category) async {
    final response=await dio.get("https://newsapi.org/v2/top-headlines/sources",
    queryParameters: {
      'apiKey':'b41a33b770bc4554bf11f2d036f6fa68',
      'category':category
    }
    );
    SourceResponse sourceResponse=SourceResponse.fromJson(response.data);
    return sourceResponse.sources??[];
  }
}