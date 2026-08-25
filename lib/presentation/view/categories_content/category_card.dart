import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/category_model.dart';
import 'package:news/l10n/app_localizations.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isEven;

  const CategoryCard({super.key, required this.category, required this.isEven});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 198.h,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // 1. الصورة: تلتصق بالجانب (يسار لو زوجي، يمين لو فردي) وتأخذ نصف العرض تقريباً
            Positioned(
              top: 0,
              bottom: 0,
              left: isEven ? 0 : null,
              right: isEven ? null : 0,
              width: 160.w,
              // عرض ثابت ومريح للصورة
              child: Image.asset(category.image, fit: BoxFit.fill),
            ),

            // 2. النصوص وزر View All في الجانب الآخر
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Align(
                // لو الصورة يمين (isEven = false)، اترك النصوص في اليمين والعكس
                alignment: isEven
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium, // أو الـ Style المناسب لديك
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection: isEven
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.viewAll,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).disabledColor,
                            // radius: 16.r,
                            child: Icon(
                              isEven
                                  ? Icons.arrow_forward_ios
                                  : Icons.arrow_back_ios_new,
                              color: Theme.of(context).canvasColor,
                              // size: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
