import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/presentation/view/news_item.dart';

class CategoryDetailsContent extends StatelessWidget {
  CategoryDetailsContent({super.key,});

  List<String> sources = [
    "CNN",
    "CNN",
    "CNN",
    "CNN",
    "CNN",
    "CNN",
    "CNN",
    "CNN",
  ];


  @override
  Widget build(BuildContext context) {
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
              tabs: sources.map((source) => Tab(text: source)).toList(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: TabBarView(children: sources.map((source)=>ListView.separated(
                  itemBuilder: (context,index)=>NewsItem(),
                  separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
                  itemCount: source.length
              )).toList()),
            ),
          )
        ],
      ),
    );
  }
}
