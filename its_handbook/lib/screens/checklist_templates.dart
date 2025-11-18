import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class ChecklistTemplates extends StatelessWidget {
  const ChecklistTemplates({super.key});

  static final templates = [
    ('New client onboarding', '18 steps / 35 min', Icons.handshake),
    ('Monthly server maintenance', '12 steps / 45 min', Icons.storage_outlined),
    ('New employee IT setup', '16 steps / 25 min', Icons.badge_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Checklist templates'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            itemBuilder: (context, index) {
              final template = templates[index];
              return GlassPanel(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      child: Icon(template.$3, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(template.$1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(template.$2),
                        ],
                      ),
                    ),
                    FilledButton.tonal(
                      onPressed: () => Navigator.pushNamed(context, '/article'),
                      child: const Text('Preview'),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemCount: templates.length,
          ),
        ),
      ),
    );
  }
}
