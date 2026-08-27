import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:news/data/model/news_response.dart';
import 'package:news/data/model/search_response.dart'; // لا تنسى إضافة استيراد ملف الـ SearchResponse
import 'package:news/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

// تعديل الدالة لتقبل أحدهما كـ Named Parameters اختيارية
showDetailsSheet(BuildContext context, {Articles? article, SearchArticles? searchArticles}) {

  // استخراج القيم الموحدة بغض النظر عن الموديل المُرسل
  final imageUrl = article?.urlToImage ?? searchArticles?.urlToImage;
  final content = article?.content ?? searchArticles?.content;
  final url = article?.url ?? searchArticles?.url;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(8.r),
        margin: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r), // تصحيح لـ BorderRadius.circular
          color: Theme.of(context).canvasColor,
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imageUrl ??
                    'https://vanseodesign.com/blog/wp-content/uploads/2015/12/newspaper.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://vanseodesign.com/blog/wp-content/uploads/2015/12/newspaper.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
            Text(
              content ?? 'No content available.',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (url != null) {
                    _launchUrl(url);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor,
                  shape: RoundedRectangleBorder( // تصحيح الخطأ الإملائي في الـ Shape إن وجد
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.r),
                ),
                child: Text(
                  AppLocalizations.of(context)!.viewFullArticel,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
