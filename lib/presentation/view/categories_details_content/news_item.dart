import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/constants/app_assets.dart';
import 'package:news/core/constants/app_text_style.dart';
import 'package:news/data/model/news_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final Articles article;
  const NewsItem({super.key,required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16.r),
        border: BoxBorder.all(color: Theme.of(context).canvasColor),
      ),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16.r),
            child: Image.network(
              article.urlToImage ?? 'https://vanseodesign.com/blog/wp-content/uploads/2015/12/newspaper.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://vanseodesign.com/blog/wp-content/uploads/2015/12/newspaper.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
            // child: Image.asset(AppAssets.news, fit: BoxFit.cover,width: double.infinity,),
          ),
          Text(
            article.title==null?'There is no title':article.title!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(child: Text(article.author==null?'UnKnown':'By : ${article.author!}',style: AppTextStyle.medium12MediumGray,)),
              Text(getTimeAgo(article.publishedAt!),style: AppTextStyle.medium12MediumGray,)
            ],
          )
        ],
      ),
    );
  }
  String getTimeAgo(String date) {
    return timeago.format(
      DateTime.parse(date),
    );
  }
}
