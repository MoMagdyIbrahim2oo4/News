import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/core/providers/app_localization_provider.dart';
import 'package:news/core/providers/theme_provider.dart';
import 'package:news/core/utils/app_routes.dart';
import 'package:news/core/utils/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/presentation/screens/home_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:news/presentation/screens/search_screen.dart';
import 'package:provider/provider.dart';

import 'dependency_injection/dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // قم بإضافة هذا السطر هنا 👇
  configureDependencies();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => AppLocalizationProvider()),
            ],
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context,);
    var languageProvider=Provider.of<AppLocalizationProvider>(context);
    return ScreenUtilPlusInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: "News",
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.homeScreen: (context) => HomeScreen(),
            AppRoutes.searchScreen: (context) => SearchScreen(),
          },
          initialRoute: AppRoutes.homeScreen,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // locale: Locale("en"),
          locale: languageProvider.language,
          // themeMode: ThemeMode.dark,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
