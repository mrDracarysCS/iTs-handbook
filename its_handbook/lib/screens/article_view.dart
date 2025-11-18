import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../services/sample_repo.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final id = args is String ? args : null;
    final article = id != null ? SampleRepository.getArticleById(id) : null;

    if (article == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Playbook / Article')),
        body: const Center(child: Text('Article not found')),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share)),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: article.tags.map((t) => Chip(label: Text(t))).toList(),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          child: Text(article.lastUpdatedBy.characters.first.toUpperCase()),
                        ),
                        title: Text('Owned by ${article.lastUpdatedBy}'),
                        subtitle: Text('Updated ${_timeAgo(article.lastUpdatedAt)}'),
                        trailing: Text(article.type.toUpperCase()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GlassPanel(
                  padding: const EdgeInsets.all(24),
                  child: Markdown(
                    data: article.content,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      h1: Theme.of(context).textTheme.headlineSmall,
                      h2: Theme.of(context).textTheme.titleLarge,
                      p: Theme.of(context).textTheme.bodyLarge,
                      codeblockDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
        label: const Text('Pin to dashboard'),
      ),
    );
  }

  String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${diff.inMinutes} min ago';
    }
  }
}
