import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/presentation/view/categories_details_content/details_sheet.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/network/news_api_service.dart';
import 'news_item.dart';

class NewsListView extends StatefulWidget {
  final String source_id;

  NewsListView({super.key, required this.source_id});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  late List<Articles>articles;

  late NewsApiService newsApiService;
  late Future<List<Articles>>initialArticles;
  bool isLoading = false;
  bool hasMore = true;

  int page = 1;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    newsApiService = NewsApiService(DioClient.instance!);
    initialArticles = newsApiService.getNews(widget.source_id, page);
  }

  loadMoreArticles() async {
    if (isLoading || !hasMore) return;
    setState(() {
      isLoading = true;
    });
    try {
      page++;
      List<Articles>newArticles = await newsApiService.getNews(
          widget.source_id, page);
      setState(() {
        isLoading = false;
        if (newArticles.isEmpty) {
          hasMore = false;
        }
        else {
          articles.addAll(newArticles);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        page--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        else {
          articles = snapshot.data!;
          return NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification) {
                final pixel = notification.metrics.pixels;
                final max = notification.metrics.maxScrollExtent;
                final maxTrigger = 200;
                if (pixel >= max - maxTrigger) {
                  loadMoreArticles();
                }
              }
              return false;
            },
            child: ListView.separated(
                itemBuilder: (context, index) {
                  if(index==articles.length){
                    return Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                      onTap: () => showDetailsSheet(context, article: articles[index]),
                      child: NewsItem(article: articles[index],));
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h,),
                itemCount: articles.length + (hasMore ? 1 : 0)
            ),
          );
        }
      },
    );
  }
}
