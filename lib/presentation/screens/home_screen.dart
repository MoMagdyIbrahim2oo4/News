import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/constants/app_icons.dart';
import 'package:news/core/providers/app_localization_provider.dart';
import 'package:news/core/providers/theme_provider.dart';
import 'package:news/data/model/category_model.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/presentation/view/categories_content.dart';
import 'package:news/presentation/view/category_details_content.dart';
import 'package:news/presentation/view/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? _categoryModel;

  // String selectedValue = 'Cairo';
  ThemeMode selectedMode = ThemeMode.dark;
  String lang='en';

  void onCategoryClicked(CategoryModel category) {
    setState(() {
      _categoryModel = category;
    });
  }

  void onDrawerClicked() {
    setState(() {
      _categoryModel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider=Provider.of<AppLocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _categoryModel == null
              ? AppLocalizations.of(context)!.home
              : _categoryModel!.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.searchIcon,
              colorFilter: ColorFilter.mode(
                Theme.of(context).canvasColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(onDrawerClicked: onDrawerClicked),
      body: _categoryModel == null
          ? CategoriesContent(onCategoryClick: onCategoryClicked)
          : CategoryDetailsContent(categoryModel: _categoryModel!,),
    );
  }
}
