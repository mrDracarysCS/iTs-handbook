import 'package:flutter/material.dart';
import '../services/sample_repo.dart';

class PlaybookLibrary extends StatelessWidget {
  const PlaybookLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = SampleRepository.getAllArticles();

    return Scaffold(
      appBar: AppBar(title: const Text('Playbook Library')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: articles.length,
        itemBuilder: (context, i) {
          final a = articles[i];
          return ListTile(
            title: Text(a.title),
            subtitle: Text(a.tags.join(' · ')),
            trailing: Text(a.type),
            onTap: () => Navigator.pushNamed(context, '/article', arguments: a.id),
          );
        },
      ),
    );
  }
}
