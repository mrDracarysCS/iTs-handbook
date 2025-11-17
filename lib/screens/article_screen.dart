import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../services/local_data_service.dart';
import '../models/article.dart';

class ArticleScreen extends StatelessWidget {
  final String? articleId;
  ArticleScreen({this.articleId});

  @override
  Widget build(BuildContext context) {
    final data = LocalDataService.instance;
    // Safely try to find the article; if not found, article will be null
    Article? article;
    if (articleId != null) {
      try {
        article = data.articles.firstWhere((a) => a.id == articleId);
      } catch (_) {
        article = null;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(article?.title ?? 'Article')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article == null) Text('Article not found') else Expanded(child: SingleChildScrollView(child: Text(article.content))),
            SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (article != null) await FavoritesService.instance.addRecent(article.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Marked in recents')));
                  },
                  child: Text('Mark recent'),
                ),
                SizedBox(width: 12),
                FutureBuilder<bool>(
                    future: article == null ? Future.value(false) : FavoritesService.instance.isFavorite(article.id),
                  builder: (context, snap) {
                    final isFav = snap.data ?? false;
                    return IconButton(
                      icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : null),
                      onPressed: article == null
                          ? null
                          : () async {
                              await FavoritesService.instance.toggleFavorite(article!.id);
                              (context as Element).markNeedsBuild();
                            },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
