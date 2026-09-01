import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/category_model.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/presentation/view/categories_details_content/news_list_view.dart';
import 'package:news/presentation/view/categories_details_content/sources_view_model.dart';
import 'package:provider/provider.dart';

import '../../../dependency_injection/dependency_injection.dart';

class CategoryDetailsContent extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryDetailsContent({super.key, required this.categoryModel});

  late List<Sources> sources;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<SourcesViewModel>()..getSources(categoryModel.id),
      child: BlocBuilder<SourcesViewModel, SourceState>(
        builder: (context, state) {
          switch (state) {
            case InitialState():
            case IsLoadingState():
              return Center(child: CircularProgressIndicator());
            case ErrorMessageState():
              return Center(
                child: Text(
                  'Error : ${state.errorMessage}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            case SuccessState():
              sources = state.sources;
              return DefaultTabController(
                length: sources.length,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Theme.of(context).canvasColor,
                      unselectedLabelStyle: Theme.of(
                        context,
                      ).textTheme.labelSmall,
                      indicatorColor: Theme.of(context).canvasColor,
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      tabs: sources
                          .map((source) => Tab(text: source.name))
                          .toList(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: TabBarView(
                          children: sources
                              .map(
                                (source) => NewsListView(source_id: source.id!),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
