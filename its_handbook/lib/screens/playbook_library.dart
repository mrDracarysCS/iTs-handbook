import 'package:flutter/material.dart';

import '../services/sample_repo.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class PlaybookLibrary extends StatefulWidget {
  const PlaybookLibrary({super.key});

  @override
  State<PlaybookLibrary> createState() => _PlaybookLibraryState();
}

class _PlaybookLibraryState extends State<PlaybookLibrary> {
  String search = '';
  String filter = 'All';
  final filters = ['All', 'Playbook', 'Runbook'];

  @override
  Widget build(BuildContext context) {
    final articles = SampleRepository.getAllArticles()
        .where((a) => filter == 'All' || a.type.toLowerCase() == filter.toLowerCase())
        .where((a) {
          if (search.isEmpty) return true;
          return a.title.toLowerCase().contains(search.toLowerCase()) ||
              a.tags.any((t) => t.toLowerCase().contains(search.toLowerCase()));
        }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Runbook view',
            onPressed: () => Navigator.pushNamed(context, '/runbooks'),
            icon: const Icon(Icons.auto_mode),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassPanel(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search title, tags, owner...',
                              ),
                              onChanged: (v) => setState(() => search = v),
                            ),
                            const SizedBox(height: 18),
                            Wrap(
                              spacing: 8,
                              children: filters
                                  .map((f) => ChoiceChip(
                                        label: Text(f),
                                        selected: filter == f,
                                        onSelected: (_) => setState(() => filter = f),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'All assets (${articles.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final article = articles[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, index == 0 ? 0 : 16, 20, index == articles.length - 1 ? 32 : 0),
                    child: GlassPanel(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(context, '/article', arguments: article.id),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          article.title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text('${article.tags.join(' / ')} - ${article.lastUpdatedBy}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            article.type.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                    childCount: articles.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
