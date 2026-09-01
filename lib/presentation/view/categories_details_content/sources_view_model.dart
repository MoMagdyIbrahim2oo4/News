import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/data/repository/news_repo.dart';
import 'package:provider/provider.dart';

// class SourcesViewModel extends ChangeNotifier{
//   bool isLoading=false;
//   String? errorMessage;
//   List<Sources>?sources;
//   Future<void> getSources(String category) async {
//     errorMessage = null;
//     isLoading = true;
//     try {
//       List<Sources>data = await NewsApiService.getSources(category);
//       sources = data;
//     } catch (e) {
//       if (e is DioException) {
//         errorMessage = e.message;
//       }
//       else {
//         errorMessage = e.toString();
//       }
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//}

sealed class SourceState {}
class InitialState extends SourceState{}
class IsLoadingState extends SourceState{}
class ErrorMessageState extends SourceState{
  final String errorMessage;
  ErrorMessageState(this.errorMessage);
}
class SuccessState extends SourceState{
  List<Sources>sources;
  SuccessState(this.sources);
}

class SourcesViewModel extends Cubit<SourceState>{
  final NewsRepo newsRep;
  SourcesViewModel(this.newsRep):super(InitialState());

Future<void> getSources(String category) async {
    emit(IsLoadingState());
    try {
      List<Sources>data = await newsRep.getSources(category);
      emit(SuccessState(data));
    } catch (e) {
      String errorMessage;
      if (e is DioException) {
        errorMessage = e.message??"Dio Error occurred";
      }
      else {
        errorMessage = e.toString();
      }
      emit(ErrorMessageState(errorMessage));
    }
  }

}