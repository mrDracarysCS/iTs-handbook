import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class RunbooksView extends StatelessWidget {
  const RunbooksView({super.key});

  static final List<_RunbookItem> runbooks = [
    _RunbookItem(
      title: 'Email outage',
      severity: 'High',
      eta: '60 min',
      description: 'Primary MX queue stalled for enterprise accounts.',
      icon: Icons.mark_email_unread_outlined,
    ),
    _RunbookItem(
      title: 'Site-to-site VPN down',
      severity: 'Critical',
      eta: '90 min',
      description: 'Tunnel instability detected for HQ <-> DC link.',
      icon: Icons.vpn_lock,
    ),
    _RunbookItem(
      title: 'Identity provider latency',
      severity: 'Medium',
      eta: '45 min',
      description: 'SSO responses degraded from global POP.',
      icon: Icons.fingerprint,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Runbooks'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            itemBuilder: (context, index) {
              final rb = runbooks[index];
              return GlassPanel(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                          child: Icon(rb.icon, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(rb.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                              Text(rb.description),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _severityColor(context, rb.severity),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            rb.severity,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 6),
                        Text('Target resolution ${rb.eta}'),
                        const Spacer(),
                        FilledButton.tonalIcon(
                          onPressed: () => Navigator.pushNamed(context, '/article', arguments: 'r1'),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Open'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemCount: runbooks.length,
          ),
        ),
      ),
    );
  }

  static Color _severityColor(BuildContext context, String severity) {
    switch (severity) {
      case 'Critical':
        return Colors.redAccent.withOpacity(0.18);
      case 'High':
        return Colors.orangeAccent.withOpacity(0.2);
      default:
        return Theme.of(context).colorScheme.primary.withOpacity(0.12);
    }
  }
}

class _RunbookItem {
  const _RunbookItem({
    required this.title,
    required this.severity,
    required this.eta,
    required this.description,
    required this.icon,
  });

  final String title;
  final String severity;
  final String eta;
  final String description;
  final IconData icon;
}
