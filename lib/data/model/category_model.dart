import 'package:flutter/cupertino.dart';
import 'package:news/core/constants/app_assets.dart';

import '../../l10n/app_localizations.dart';

class CategoryModel {
  String name;
  String image;

  CategoryModel({required this.name, required this.image});

  static List<CategoryModel> getCategories(BuildContext context) {
    return [
      CategoryModel(
        name: AppLocalizations.of(context)!.general,
        image: AppAssets.general,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.business,
        image: AppAssets.business,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.entertainment,
        image: AppAssets.entertainment,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.health,
        image: AppAssets.health,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.science,
        image: AppAssets.science,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.technology,
        image: AppAssets.technology,
      ),
      CategoryModel(
        name: AppLocalizations.of(context)!.sport,
        image: AppAssets.sport,
      ),
    ];
  }
}
