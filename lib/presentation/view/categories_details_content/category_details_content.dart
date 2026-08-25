import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/core/network/news_api_service.dart';
import 'package:news/data/model/category_model.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/presentation/view/categories_details_content/news_item.dart';
import 'package:news/presentation/view/categories_details_content/news_list_view.dart';

class CategoryDetailsContent extends StatelessWidget {
  final CategoryModel categoryModel;
  CategoryDetailsContent({super.key,required this.categoryModel});

  late List<Sources>sources;
  NewsApiService newsApiService=NewsApiService(DioClient.instance!);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: newsApiService.getSources(categoryModel.id),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            final error=snapshot.error;
            final message=error is DioException? error.message:'Unknown';
            return Center(child: Center(child: Text('Error: $message',style: Theme.of(context).textTheme.displayMedium,)));
          }
          else{
            sources=snapshot.data!;
            return DefaultTabController(
              length: sources.length,
              child: Column(
                children: [
                  TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Theme.of(context).canvasColor,
                      unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
                      indicatorColor: Theme.of(context).canvasColor,
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      tabs: sources.map((source) => Tab(text: source.name)).toList(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: TabBarView(children: sources.map((source)=>NewsListView(source_id: source.id!,)).toList()),
                    ),
                  )
                ],
              ),
            );
          }
        },
    );
  }
}
