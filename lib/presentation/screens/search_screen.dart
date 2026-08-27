import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/core/network/news_api_service.dart';

import '../../data/model/news_response.dart';
import '../../data/model/search_response.dart';
import '../view/categories_details_content/details_sheet.dart';
import '../view/categories_details_content/news_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  late List<SearchArticles>articles;

  late NewsApiService newsApiService;
  late Future<List<SearchArticles>>initialArticles;
  bool isLoading = false;
  bool hasMore = true;

  int page = 1;
  String searchItem='';

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _controller=TextEditingController();
    newsApiService=NewsApiService(DioClient.instance!);
    initialArticles=newsApiService.search(searchItem, page);
  }
  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _controller.dispose();
  }

  loadMoreArticles() async {
    if (isLoading || !hasMore) return;
    setState(() {
      isLoading = true;
    });
    try {
      page++;
      List<SearchArticles>newArticles = await newsApiService.search(
          searchItem, page);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            spacing: 16.h,
            children: [
              TextFormField(
                controller: _controller,
                style: Theme.of(context).textTheme.labelSmall,
                onChanged: (value){
                  setState(() {
                    searchItem=value;
                    page=1;
                    hasMore=true;
                    initialArticles=newsApiService.search(searchItem, page);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'What you search for...'
                ),
              ),
              Expanded(
                child: FutureBuilder(
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
                              if(articles.isEmpty){
                                return Center(child: Text("No News",style: Theme.of(context).textTheme.labelSmall,));
                              }
                              if(index==articles.length){
                                return Center(child: CircularProgressIndicator());
                              }
                              return GestureDetector(
                                  onTap: () => showDetailsSheet(context, searchArticles: articles[index]),
                                  child: NewsItem( searchArticles: articles[index],));
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 16.h,),
                            itemCount: articles.length + (hasMore ? 1 : 0)
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
