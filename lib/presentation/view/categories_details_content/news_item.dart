import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/constants/app_text_style.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final Articles? article;
  final SearchArticles? searchArticles;

  const NewsItem({super.key,this.article,this.searchArticles});

  @override
  Widget build(BuildContext context) {
    // هنا بنعمل استخراج للبيانات أياً كان الموديل اللي باعتو اليوزر
    final imageUrl = article?.urlToImage ?? searchArticles?.urlToImage;
    final title = article?.title ?? searchArticles?.title;
    final author = article?.author ?? searchArticles?.author;
    final publishedAt = article?.publishedAt ?? searchArticles?.publishedAt;

    return Container(
      padding: EdgeInsets.all(8.r),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r), // تم تصحيحها لـ BorderRadius.circular بدلاً من BorderRadiusGeometry
        border: Border.all(color: Theme.of(context).canvasColor), // تم تصحيحها لـ Border.all
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              imageUrl ?? 'https://vanseodesign.com/blog/wp-content/uploads/2015/12/newspaper.jpg',
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
          ),
          Text(
            title == null ? 'There is no title' : title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  author == null ? 'UnKnown' : 'By : $author',
                  style: AppTextStyle.medium12MediumGray,
                ),
              ),
              if (publishedAt != null)
                Text(
                  getTimeAgo(publishedAt),
                  style: AppTextStyle.medium12MediumGray,
                ),
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
