import 'package:flutter/material.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin / Settings')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          ListTile(title: Text('Manage users & roles')),
          ListTile(title: Text('Manage categories')),
          ListTile(title: Text('Version history (basic)')),
        ],
      ),
    );
  }
}
