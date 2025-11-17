class Tag {
  final String id;
  final String label;

  Tag({required this.id, required this.label});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'] as String,
        label: json['label'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
      };
}
