class Article {
  final String id;
  final String title;
  final String content; // Rich text / markdown
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
    required this.tags,
    required this.lastUpdatedBy,
    required this.lastUpdatedAt,
    required this.type,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        categoryId: json['categoryId'] as String,
        tags: List<String>.from(json['tags'] ?? []),
        lastUpdatedBy: json['lastUpdatedBy'] as String? ?? '',
        lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
        type: json['type'] as String? ?? 'playbook',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'categoryId': categoryId,
        'tags': tags,
        'lastUpdatedBy': lastUpdatedBy,
        'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
        'type': type,
      };
}
