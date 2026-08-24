import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/constants/app_colors.dart';

class AppTextStyle {

  static final TextStyle medium20White=GoogleFonts.inter(
    color: AppColors.backgroundLight,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium20DarkGray=GoogleFonts.inter(
    color: AppColors.backgroundDark,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium24white=GoogleFonts.inter(
    color: AppColors.backgroundLight,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium24DarkGray=GoogleFonts.inter(
    color: AppColors.backgroundDark,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium14White=GoogleFonts.inter(
    color: AppColors.backgroundLight,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium14DarkGray=GoogleFonts.inter(
    color: AppColors.backgroundDark,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bold16White=GoogleFonts.inter(
    color: AppColors.backgroundLight,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bold16DarkGray=GoogleFonts.inter(
    color: AppColors.backgroundDark,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium12MediumGray=GoogleFonts.inter(
    color: AppColors.mediumGray,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bold24Gray=GoogleFonts.inter(
    color: AppColors.backgroundDark,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bold20white=GoogleFonts.inter(
    color: AppColors.backgroundLight,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
}