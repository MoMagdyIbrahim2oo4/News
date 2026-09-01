import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/providers/app_localization_provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../l10n/app_localizations.dart';
import '../widget/drawer_container.dart';

class CustomDrawer extends StatelessWidget {
  final void Function()onDrawerClicked;
  CustomDrawer({super.key,required this.onDrawerClicked});
  ThemeMode selectedMode = ThemeMode.dark;
  String lang='en';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider=Provider.of<AppLocalizationProvider>(context);
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.backgroundLight),
            child: Center(
              child: Text(AppLocalizations.of(context)!.newsApp, style: AppTextStyle.bold24Gray),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(AppIcons.homeIcon),
            title: Text(AppLocalizations.of(context)!.goToHome, style: AppTextStyle.bold20white),
            onTap: () {
              onDrawerClicked();
              Navigator.pop(context);
            },
          ),
          Divider(indent: 20.w, endIndent: 20.w),
          ListTile(
            leading: SvgPicture.asset(AppIcons.themeIcon),
            title: Text(AppLocalizations.of(context)!.theme, style: AppTextStyle.bold20white),
          ),
          DrawerContainer(
            title: themeProvider.isDark ? AppLocalizations.of(context)!.dark : AppLocalizations.of(context)!.light,
            widget: DropdownButton<ThemeMode>(
              value: selectedMode,
              underline: SizedBox(),
              dropdownColor: AppColors.backgroundDark,
              selectedItemBuilder: (context) {
                return [SizedBox(),SizedBox()];
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.light, style: AppTextStyle.medium14White),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.dark, style: AppTextStyle.medium14White),
                ),
              ],
              onChanged: (value) {
                selectedMode = value!;
                themeProvider.setThemeMode(selectedMode);
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 24.h,),
          Divider(indent: 20.w, endIndent: 20.w),
          ListTile(
            leading: SvgPicture.asset(AppIcons.languageIcon),
            title: Text(AppLocalizations.of(context)!.language, style: AppTextStyle.bold20white),
          ),
          DrawerContainer(
            title: languageProvider.language==Locale('en') ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.arabic,
            widget: DropdownButton<String>(
              value: lang,
              underline: SizedBox(),
              dropdownColor: AppColors.backgroundDark,
              selectedItemBuilder: (context) {
                return [SizedBox(),SizedBox()];
              },
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(AppLocalizations.of(context)!.english, style: AppTextStyle.medium14White),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text(AppLocalizations.of(context)!.arabic, style: AppTextStyle.medium14White),
                ),
              ],
              onChanged: (value) {
                lang = value!;
                languageProvider.setLocalization(lang);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
