import 'package:flutter/cupertino.dart';
import 'package:news/core/constants/app_assets.dart';

import '../../l10n/app_localizations.dart';

class CategoryModel {
  String id;
  String name;
  String image;

  CategoryModel({required this.id,required this.name, required this.image});

  static List<CategoryModel> getCategories(BuildContext context) {
    return [
      CategoryModel(
        id: 'general',
        name: AppLocalizations.of(context)!.general,
        image: AppAssets.general,
      ),
      CategoryModel(
        id: 'business',
        name: AppLocalizations.of(context)!.business,
        image: AppAssets.business,
      ),
      CategoryModel(
        id: 'entertainment',
        name: AppLocalizations.of(context)!.entertainment,
        image: AppAssets.entertainment,
      ),
      CategoryModel(
        id: 'health',
        name: AppLocalizations.of(context)!.health,
        image: AppAssets.health,
      ),
      CategoryModel(
        id: 'science',
        name: AppLocalizations.of(context)!.science,
        image: AppAssets.science,
      ),
      CategoryModel(
        id: 'technology',
        name: AppLocalizations.of(context)!.technology,
        image: AppAssets.technology,
      ),
      CategoryModel(
        id: 'sports',
        name: AppLocalizations.of(context)!.sport,
        image: AppAssets.sport,
      ),
    ];
  }
}
