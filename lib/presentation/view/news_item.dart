import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/constants/app_assets.dart';
import 'package:news/core/constants/app_text_style.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

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
            child: Image.asset(AppAssets.news, fit: BoxFit.cover,width: double.infinity,),
          ),
          Text(
            "40-year-old man falls 200 feet to his death while canyoneering at national park",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("By : Jon Haworth",style: AppTextStyle.medium12MediumGray,),
              Text("15 minutes ago",style: AppTextStyle.medium12MediumGray,)
            ],
          )
        ],
      ),
    );
  }
}
