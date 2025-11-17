import 'package:flutter/material.dart';

class ChecklistTemplates extends StatelessWidget {
  const ChecklistTemplates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Templates')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(child: ListTile(title: const Text('New client onboarding'))),
          Card(child: ListTile(title: const Text('Monthly server maintenance'))),
          Card(child: ListTile(title: const Text('New employee IT setup'))),
        ],
      ),
    );
  }
}
