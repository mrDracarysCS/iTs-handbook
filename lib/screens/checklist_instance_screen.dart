import 'package:flutter/material.dart';

class ChecklistInstanceScreen extends StatelessWidget {
  final String? instanceId;
  ChecklistInstanceScreen({this.instanceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checklist')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Checklist instance: ${instanceId ?? '(new)'}'),
      ),
    );
  }
}
