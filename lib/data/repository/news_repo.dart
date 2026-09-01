import 'package:news/data/local_data_source/local_data_source.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/data/remote_data_source/remote_data_source.dart';

abstract class NewsRepo {
  Future<List<Sources>> getSources(String category);

  Future<List<Articles>> getArticles(String sourceId, int page);

  Future<List<SearchArticles>> search(String searchItem, int page);
}

class NewsRepoImp implements NewsRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  NewsRepoImp(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Articles>> getArticles(String sourceId, int page) async {
    if (true) {
      return await remoteDataSource.getArticles(sourceId, page);
    } else {
      return await localDataSource.getArticles(sourceId, page);
    }
  }

  @override
  Future<List<Sources>> getSources(String category) async {
    if (true) {
      return await remoteDataSource.getSources(category);
    } else {
      return await localDataSource.getSources(category);
    }
  }

  @override
  Future<List<SearchArticles>> search(String searchItem, int page) async {
    if (true) {
      return await remoteDataSource.search(searchItem, page);
    } else {
      return await localDataSource.search(searchItem, page);
    }
  }
}
