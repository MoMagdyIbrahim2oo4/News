import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/presentation/view/categories_details_content/details_sheet.dart';
import 'package:news/presentation/view/categories_details_content/news_view_model.dart';
import '../../../dependency_injection/dependency_injection.dart';
import 'news_item.dart';

class NewsListView extends StatelessWidget {
  final String source_id;

  NewsListView({super.key, required this.source_id});

  late List<Articles> articles;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<NewsViewModel>()..getArticles(source_id),
      child: BlocBuilder<NewsViewModel, NewState>(
        builder: (context, state) {
          switch (state) {
            case IsLoadingState():
              return Center(child: CircularProgressIndicator());
            case ErrorMessageState():
              return Text(
                'Error : ${state.errorMessage}',
                style: Theme.of(context).textTheme.displayMedium,
              );
            case SuccessState():
              articles = state.articles;
              final newsViewModel=context.read<NewsViewModel>();
                  return NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollUpdateNotification) {
                        final pixel = notification.metrics.pixels;
                        final max = notification.metrics.maxScrollExtent;
                        final maxTrigger = 200;
                        if (pixel >= max - maxTrigger) {
                          newsViewModel.loadMoreArticles(source_id);
                        }
                      }
                      return false;
                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == articles.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return GestureDetector(
                          onTap: () =>
                              showDetailsSheet(context, article: articles[index]),
                          child: NewsItem(article: articles[index]),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemCount: articles.length + (newsViewModel.hasMore ? 1 : 0),
                    ),
                  );

            case InitialState():
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        },
      ),
    );
  }
}
