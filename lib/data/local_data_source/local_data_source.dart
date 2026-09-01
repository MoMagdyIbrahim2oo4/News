import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart';
import 'package:news/data/model/source_response.dart';

class LocalDataSource {
  final NewsApiService newsApiService;

  LocalDataSource(this.newsApiService);

  Future<List<Sources>> getSources(String category) async {
    return await newsApiService.getSources(category);
  }

  Future<List<Articles>> getArticles(String sourceId, int page) async {
    return await newsApiService.getNews(sourceId, page);
  }

  Future<List<SearchArticles>> search(String searchItem, int page) async {
    return await newsApiService.search(searchItem, page);
  }
}
