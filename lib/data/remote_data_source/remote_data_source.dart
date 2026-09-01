import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart';
import 'package:news/data/model/source_response.dart';

abstract class RemoteDataSource {
  Future<List<Sources>> getSources(String category);

  Future<List<Articles>> getArticles(String sourceId, int page);

  Future<List<SearchArticles>> search(String searchItem, int page);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final NewsApiService newsApiService;

  RemoteDataSourceImp(this.newsApiService);

  @override
  Future<List<Sources>> getSources(String category) async {
    return await newsApiService.getSources(category);
  }

  @override
  Future<List<Articles>> getArticles(String sourceId, int page) async {
    return await newsApiService.getNews(sourceId, page);
  }

  @override
  Future<List<SearchArticles>> search(String searchItem, int page) async {
    return await newsApiService.search(searchItem, page);
  }
}
