import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/network/news_api_service.dart';
import 'package:news/presentation/screens/searchViewModel/search_view_model.dart';
import '../../data/model/search_response.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../view/categories_details_content/details_sheet.dart';
import '../view/categories_details_content/news_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchArticles> articles = [];



  String searchItem = '';


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SearchViewModel>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Builder(
              builder: (context) {
                return Column(
                  spacing: 16.h,
                  children: [
                    TextFormField(
                      style: Theme.of(context).textTheme.labelSmall,
                      onChanged: (value) {
                        setState(() {
                          searchItem = value;
                        });
                        if (value.trim().isEmpty) {
                          context.read<SearchViewModel>().emitNoData();
                          return;
                        }
                        context.read<SearchViewModel>().getArticles(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'What you search for...',
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<SearchViewModel, SearchState>(
                        builder: (context, state) {
                          switch (state) {
                            case IsLoadingState():
                              return Center(child: CircularProgressIndicator());
                            case ErrorMessageState():
                              return Text(
                                'Error : ${state.errorMessage}',
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              );
                            case SuccessState():
                              articles = state.articles;
                              if (articles.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No News',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                );
                              }
                              final searchViewModel = context
                                  .read<SearchViewModel>();
                              return NotificationListener(
                                onNotification:
                                    (ScrollNotification notification) {
                                      if (notification
                                          is ScrollUpdateNotification) {
                                        final pixel =
                                            notification.metrics.pixels;
                                        final max = notification
                                            .metrics
                                            .maxScrollExtent;
                                        final maxTrigger = 200;
                                        if (pixel >= max - maxTrigger) {
                                          searchViewModel.loadMoreArticles(
                                            searchItem,
                                          );
                                        }
                                      }
                                      return false;
                                    },
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    if (articles.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No News",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall,
                                        ),
                                      );
                                    }
                                    if (index == articles.length) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () => showDetailsSheet(
                                        context,
                                        searchArticles: articles[index],
                                      ),
                                      child: NewsItem(
                                        searchArticles: articles[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16.h),
                                  itemCount:
                                      articles.length + (context.read<SearchViewModel>().hasMore ? 1 : 0),
                                ),
                              );
                            case NoData():
                              return Text(
                                'No News',
                                style: Theme.of(context).textTheme.labelSmall,
                              );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
