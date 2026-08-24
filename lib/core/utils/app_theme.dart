import 'package:flutter/material.dart';
import 'package:news/core/constants/app_colors.dart';
import 'package:news/core/constants/app_text_style.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.backgroundDark
      ),
    ),
    disabledColor: AppColors.backgroundLight,
    canvasColor: AppColors.backgroundDark,
    highlightColor: AppColors.backgroundLight.withValues(alpha: 0.5),
    textTheme: TextTheme(
      titleLarge: AppTextStyle.medium20DarkGray,
      displayLarge: AppTextStyle.medium24DarkGray,
      displayMedium: AppTextStyle.medium24white,
      displaySmall: AppTextStyle.medium24DarkGray,
        labelSmall: AppTextStyle.medium14DarkGray,
      labelMedium: AppTextStyle.bold16DarkGray,

    )
  );

  static final ThemeData darkTheme=ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
            color: AppColors.backgroundLight
        ),
      ),
      disabledColor: AppColors.backgroundDark,
      canvasColor: AppColors.backgroundLight,
      highlightColor: AppColors.gray.withValues(alpha: 0.5),
      textTheme: TextTheme(
          titleLarge: AppTextStyle.medium20White,
          displayLarge: AppTextStyle.medium24white,
        displayMedium:  AppTextStyle.medium24DarkGray,
          displaySmall: AppTextStyle.medium24white,
        labelSmall: AppTextStyle.medium14White,
        labelMedium: AppTextStyle.bold16White,
      )
  );
}