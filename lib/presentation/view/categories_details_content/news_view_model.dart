import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/repository/news_repo.dart';

// class NewsViewModel extends ChangeNotifier{
//   bool isLoading=false;
//   bool isPaginationLoading=false;
//   bool hasMore=true;
//   int page=1;
//   String? errorMessage;
//   List<Articles>?articles;
//   Future<void> getArticles(String source) async {
//     errorMessage=null;
//     isLoading=true;
//     try{
//       List<Articles>data=await NewsApiService.getNews(source, page);
//       articles=data;
//     }
//     catch(e){
//       if(e is DioException){
//         errorMessage=e.message;
//       }
//       else{
//         errorMessage=e.toString();
//       }
//     }
//     isLoading=false;
//     notifyListeners();
//   }
//
//   Future<void> loadMoreArticles(String sourceId) async {
//     if (isPaginationLoading || !hasMore) return;
//
//     isPaginationLoading = true;
//     notifyListeners();
//
//     try {
//       page++;
//       List<Articles> newArticles = await NewsApiService.getNews(
//         sourceId,
//         page,
//       );
//
//       isPaginationLoading = false;
//
//       if (newArticles.isEmpty) {
//         hasMore = false;
//       } else {
//         articles?.addAll(newArticles);
//       }
//       notifyListeners();
//
//     } catch (e) {
//       isPaginationLoading = false;
//       page--;
//       if (e is DioException) {
//         errorMessage = e.message;
//       } else {
//         errorMessage = e.toString();
//       }
//       notifyListeners();
//     }
//   }
// }

sealed class NewState{}
class InitialState extends NewState{}
class IsLoadingState extends NewState{}
class ErrorMessageState extends NewState{
  final String errorMessage;
  ErrorMessageState(this.errorMessage);
}
class SuccessState extends NewState{
  List<Articles>articles;
  SuccessState(this.articles);

}

class NewsViewModel extends Cubit<NewState>{
  final NewsRepo newsRepo;
  NewsViewModel(this.newsRepo):super(InitialState());
  bool isPaginationLoading=false;
  bool hasMore=true;
  int page=1;
  List<Articles>currentArticles=[];

  Future<void> getArticles(String source) async {
    emit(IsLoadingState());
    try{
      List<Articles>data=await newsRepo.getArticles(source, page);
      currentArticles=data;
      emit(SuccessState(currentArticles));
    }
    catch(e){
      String errorMessage;
      if(e is DioException){
        errorMessage=e.message??"Dio Error occurred";
      }
      else{
        errorMessage=e.toString();
      }
      emit(ErrorMessageState(errorMessage));
    }
    isPaginationLoading=false;
  }

  Future<void> loadMoreArticles(String sourceId) async {
    if (isPaginationLoading || !hasMore) return;

    isPaginationLoading = true;

    try {
      page++;
      List<Articles> newArticles = await newsRepo.getArticles(
        sourceId,
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
        errorMessage = e.message??"Dio Error occurred";
      } else {
        errorMessage = e.toString();
      }
      emit(ErrorMessageState(errorMessage));
    }
  }
}