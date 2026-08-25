import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/news_response.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/network/news_api_service.dart';
import 'news_item.dart';

class NewsListView extends StatelessWidget {
  final String source_id;
  NewsListView({super.key,required this.source_id});
  late List<Articles>articles;
  NewsApiService newsApiService=NewsApiService(DioClient.instance!);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: newsApiService.getNews(source_id),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          else{
            articles=snapshot.data!;
            return ListView.separated(
                itemBuilder: (context,index)=>NewsItem(article: articles[index],),
                separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
                itemCount: articles.length
            );
          }
        },
    );

  }
}
