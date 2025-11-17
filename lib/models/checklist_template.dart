class ChecklistItem {
  final String id;
  final String text;

  ChecklistItem({required this.id, required this.text});

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => ChecklistItem(
        id: json['id'] as String,
        text: json['text'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
      };
}

class ChecklistTemplate {
  final String id;
  final String title;
  final List<ChecklistItem> items;

  ChecklistTemplate({required this.id, required this.title, required this.items});

  factory ChecklistTemplate.fromJson(Map<String, dynamic> json) => ChecklistTemplate(
        id: json['id'] as String,
        title: json['title'] as String,
        items: (json['items'] as List<dynamic>?)?.map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'items': items.map((i) => i.toJson()).toList(),
      };
}
