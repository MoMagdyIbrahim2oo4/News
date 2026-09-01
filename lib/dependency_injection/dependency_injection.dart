import 'package:get_it/get_it.dart';
import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/local_data_source/local_data_source.dart';
import 'package:news/data/remote_data_source/remote_data_source.dart';
import 'package:news/data/repository/news_repo.dart';
import 'package:news/presentation/screens/searchViewModel/search_view_model.dart';
import 'package:news/presentation/view/categories_details_content/news_view_model.dart';
import 'package:news/presentation/view/categories_details_content/sources_view_model.dart';


final getIt = GetIt.instance;

void configureDependencies() {

  getIt.registerSingleton<NewsApiService>(NewsApiService());

  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSource(getIt<NewsApiService>()));
  getIt.registerLazySingleton<RemoteDataSourceImp>(() => RemoteDataSourceImp(getIt<NewsApiService>()));
  getIt.registerLazySingleton<NewsRepoImp>(() => NewsRepoImp(getIt<RemoteDataSourceImp>(), getIt<LocalDataSource>()));
  getIt.registerFactory<SourcesViewModel>(() => SourcesViewModel(getIt<NewsRepoImp>()));
  getIt.registerFactory<NewsViewModel>(() => NewsViewModel(getIt<NewsRepoImp>()));
  getIt.registerFactory<SearchViewModel>(() => SearchViewModel(getIt<NewsRepoImp>()));
}