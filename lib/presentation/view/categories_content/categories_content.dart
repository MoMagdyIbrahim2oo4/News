import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../data/model/category_model.dart';
import '../../../l10n/app_localizations.dart';
import 'category_card.dart';

class CategoriesContent extends StatelessWidget {
  void Function(CategoryModel) onCategoryClick;
  CategoriesContent({super.key,required this.onCategoryClick});


  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = CategoryModel.getCategories(context);
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: .start,
        children: [
          Text(
            AppLocalizations.of(context)!.goodMorning,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  onCategoryClick(categories[index]);
                },
                child: CategoryCard(
                  category: categories[index],
                  isEven: (index % 2) == 0,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
