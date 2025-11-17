import 'package:flutter/material.dart';
import '../services/sample_repo.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final pinned = SampleRepository.pinned();
    final recents = SampleRepository.recents();

    return Scaffold(
      appBar: AppBar(title: const Text("IT's Handbook")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Playbook Library'),
              onTap: () => Navigator.pushNamed(context, '/library'),
            ),
            ListTile(
              title: const Text('Runbooks'),
              onTap: () => Navigator.pushNamed(context, '/runbooks'),
            ),
            ListTile(
              title: const Text('Checklists'),
              onTap: () => Navigator.pushNamed(context, '/checklists'),
            ),
            ListTile(
              title: const Text('Admin / Settings'),
              onTap: () => Navigator.pushNamed(context, '/admin'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search playbooks, tags, keywords',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Continue where you left off', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (recents.isEmpty) const Text('No recent items') else Column(children: recents.map((r) => Card(child: ListTile(title: Text(r.title), onTap: () => Navigator.pushNamed(context, '/article', arguments: r.id)))).toList()),
            const SizedBox(height: 12),
            const Text('Pinned Playbooks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (pinned.isEmpty) const Text('No pinned items') else Column(children: pinned.map((p) => Card(child: ListTile(title: Text(p.title), onTap: () => Navigator.pushNamed(context, '/article', arguments: p.id)))).toList()),
            const SizedBox(height: 12),
            const Text('Common Runbooks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(child: ListTile(title: const Text('Email outage'), onTap: () => Navigator.pushNamed(context, '/runbooks'))),
          ],
        ),
      ),
    );
  }
}
