class ChecklistInstanceItem {
  final String id;
  final String text;
  bool done;
  DateTime? doneAt;

  ChecklistInstanceItem({required this.id, required this.text, this.done = false, this.doneAt});

  factory ChecklistInstanceItem.fromJson(Map<String, dynamic> json) => ChecklistInstanceItem(
        id: json['id'] as String,
        text: json['text'] as String,
        done: json['done'] as bool? ?? false,
        doneAt: json['doneAt'] == null ? null : DateTime.parse(json['doneAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'done': done,
        'doneAt': doneAt?.toIso8601String(),
      };
}

class ChecklistInstance {
  final String id;
  final String templateId;
  String title;
  final String createdBy;
  final DateTime createdAt;
  String status; // 'in-progress' | 'complete'
  final List<ChecklistInstanceItem> items;

  ChecklistInstance({
    required this.id,
    required this.templateId,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.status,
    required this.items,
  });

  factory ChecklistInstance.fromJson(Map<String, dynamic> json) => ChecklistInstance(
        id: json['id'] as String,
        templateId: json['templateId'] as String,
        title: json['title'] as String,
        createdBy: json['createdBy'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        status: json['status'] as String? ?? 'in-progress',
        items: (json['items'] as List<dynamic>?)?.map((e) => ChecklistInstanceItem.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'templateId': templateId,
        'title': title,
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
        'items': items.map((i) => i.toJson()).toList(),
      };
}
