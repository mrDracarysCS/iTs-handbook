import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});

  static final settings = [
    (Icons.groups, 'Manage users & roles', 'Sync Okta groups, elevate owners.'),
    (Icons.category_outlined, 'Categories & tags', 'Curate taxonomies to keep search relevant.'),
    (Icons.history, 'Version history', 'Track edits, rollback and approvals.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Admin & governance'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            itemBuilder: (context, index) {
              final setting = settings[index];
              return GlassPanel(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Icon(setting.$1, size: 32, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(setting.$2, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(setting.$3),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemCount: settings.length,
          ),
        ),
      ),
    );
  }
}
