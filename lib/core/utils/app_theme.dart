import 'package:flutter/material.dart';
import 'package:news/core/constants/app_colors.dart';
import 'package:news/core/constants/app_text_style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.backgroundDark,
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
      labelLarge: AppTextStyle.medium14White,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.mediumGray,
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.backgroundDark,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),

      hintStyle: AppTextStyle.medium14DarkGray.copyWith(
        color: AppColors.mediumGray,
      ),
      labelStyle: AppTextStyle.medium14DarkGray,
      prefixIconColor: AppColors.backgroundDark,
      suffixIconColor: AppColors.backgroundDark,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.backgroundLight,
      ),
    ),
    disabledColor: AppColors.backgroundDark,
    canvasColor: AppColors.backgroundLight,
    highlightColor: AppColors.gray.withValues(alpha: 0.5),
    textTheme: TextTheme(
      titleLarge: AppTextStyle.medium20White,
      displayLarge: AppTextStyle.medium24white,
      displayMedium: AppTextStyle.medium24DarkGray,
      displaySmall: AppTextStyle.medium24white,
      labelSmall: AppTextStyle.medium14White,
      labelMedium: AppTextStyle.bold16White,
      labelLarge: AppTextStyle.medium14DarkGray,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),


      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.mediumGray,
          width: 1.2,
        ),
      ),


      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.backgroundLight,
          width: 1.5,
        ),
      ),

      // حدود الخطأ
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.2,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius:BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),

      hintStyle: AppTextStyle.medium14White.copyWith(
        color: AppColors.mediumGray,
      ),
      labelStyle: AppTextStyle.medium14White,
      prefixIconColor: AppColors.backgroundLight,
      suffixIconColor: AppColors.backgroundLight,
    ),
  );
}