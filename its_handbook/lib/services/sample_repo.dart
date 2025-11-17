import '../models/article.dart';

class SampleRepository {
  static final List<Article> articles = [
    Article(
      id: 'a1',
      title: 'pfSense New Client Setup',
      content: 'Step 1: Provision VM\nStep 2: Install pfSense\nStep 3: Configure WAN/LAN',
      categoryId: 'networking',
      tags: ['pfSense', 'Networking'],
      lastUpdatedBy: 'alice',
      lastUpdatedAt: DateTime.now().subtract(const Duration(days: 2)),
      type: 'playbook',
    ),
    Article(
      id: 'a2',
      title: 'S3 Bucket Policy Template',
      content: 'Example policy:\n{ ... }',
      categoryId: 'cloud',
      tags: ['AWS', 'S3'],
      lastUpdatedBy: 'bob',
      lastUpdatedAt: DateTime.now().subtract(const Duration(days: 5)),
      type: 'playbook',
    ),
    Article(
      id: 'r1',
      title: 'Email outage',
      content: 'Runbook for email outage\n- Verify MX records\n- Check provider status',
      categoryId: 'incidents',
      tags: ['Email', 'Incident'],
      lastUpdatedBy: 'oncall',
      lastUpdatedAt: DateTime.now().subtract(const Duration(hours: 12)),
      type: 'runbook',
    ),
  ];

  static List<Article> getAllArticles() => articles;

  static Article? getArticleById(String id) {
    try {
      return articles.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Article> pinned() => [articles.first];

  static List<Article> recents() => articles.take(2).toList();
}
