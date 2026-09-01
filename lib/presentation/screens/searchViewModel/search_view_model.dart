import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/model/search_response.dart';
import 'package:news/data/repository/news_repo.dart';

import '../../../core/network/news_api_service.dart';

sealed class SearchState {}

class NoData extends SearchState {}

class IsLoadingState extends SearchState {}

class ErrorMessageState extends SearchState {
  final String errorMessage;

  ErrorMessageState(this.errorMessage);
}

class SuccessState extends SearchState {
  List<SearchArticles> articles;

  SuccessState(this.articles);
}

class SearchViewModel extends Cubit<SearchState> {
  final NewsRepo newsRepo;

  SearchViewModel(this.newsRepo) : super(NoData());
  List<SearchArticles> currentArticles = [];
  int page = 1;
  bool isPaginationLoading = false;
  bool hasMore = true;
  String currentSearch = '';

  void emitNoData() {
    currentSearch = '';
    currentArticles.clear();
    emit(NoData());
  }

  Future<void> getArticles(String searchItem) async {
    currentSearch = searchItem;
    emit(IsLoadingState());
    page = 1;
    hasMore = true;
    try {
      List<SearchArticles> data = await newsRepo.search(searchItem, page);
      // لو البحث اتغير أو اتمسح
      if (currentSearch != searchItem) {
        return;
      }
      currentArticles = data;
      emit(SuccessState(currentArticles));
    } catch (e) {
      String errorMessage;
      if (e is DioException) {
        errorMessage = e.message ?? "Dio Error occurred";
      } else {
        errorMessage = e.toString();
      }
      emit(ErrorMessageState(errorMessage));
    }
  }

  Future<void> loadMoreArticles(String searchItem) async {
    if (isPaginationLoading || !hasMore) return;

    isPaginationLoading = true;

    try {
      page++;
      List<SearchArticles> newArticles = await newsRepo.search(
        searchItem,
        page,
      );

      isPaginationLoading = false;

      if (newArticles.isEmpty) {
        hasMore = false;
      } else {
        currentArticles.addAll(newArticles);
      }
      emit(SuccessState(currentArticles));
    } catch (e) {
      String errorMessage;
      isPaginationLoading = false;
      page--;
      if (e is DioException) {
        errorMessage = e.message ?? "Dio Error occurred";
      } else {
        errorMessage = e.toString();
      }
      emit(ErrorMessageState(errorMessage));
    }
  }
}
