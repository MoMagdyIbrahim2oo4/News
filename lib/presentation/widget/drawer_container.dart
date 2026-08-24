import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/constants/app_text_style.dart';

import '../../core/constants/app_colors.dart';

class DrawerContainer extends StatelessWidget {
  final String title;
  final Widget widget;
  const DrawerContainer({super.key,required this.title,required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadiusGeometry.circular(16.r),
        border: BoxBorder.all(color: Colors.white)
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title,style: AppTextStyle.medium20White,),
          widget
        ],
      ),
    );
  }
}
