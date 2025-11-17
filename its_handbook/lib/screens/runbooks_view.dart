import 'package:flutter/material.dart';

class RunbooksView extends StatelessWidget {
  const RunbooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Runbooks')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              title: const Text('Email outage'),
              subtitle: const Text('Severity: High · Est. 60 min'),
              onTap: () => Navigator.pushNamed(context, '/article'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Site-to-site VPN down'),
              subtitle: const Text('Severity: Critical · Est. 90 min'),
              onTap: () => Navigator.pushNamed(context, '/article'),
            ),
          ),
        ],
      ),
    );
  }
}
