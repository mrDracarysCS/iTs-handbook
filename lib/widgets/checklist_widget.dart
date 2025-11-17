import 'package:flutter/material.dart';

class ChecklistWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  ChecklistWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return CheckboxListTile(
          value: item['done'] as bool? ?? false,
          onChanged: (_) {},
          title: Text(item['text'] as String? ?? ''),
        );
      },
    );
  }
}
