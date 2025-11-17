class Article {
  final String id;
  final String title;
  final String content;
  final String categoryId;
  final List<String> tags;
  final String lastUpdatedBy;
  final DateTime lastUpdatedAt;
  final String type; // 'playbook' | 'runbook'

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    this.tags = const [],
    required this.lastUpdatedBy,
    required this.lastUpdatedAt,
    required this.type,
  });
}
