import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/sample_repo.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  String search = '';
  final categories = ['All', 'Networking', 'Cloud', 'Security', 'Systems', 'Runbooks'];
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final pinned = SampleRepository.pinned()
        .where((a) => a.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    final recents = SampleRepository.recents()
        .where((a) => selectedCategory == 'All' || a.tags.contains(selectedCategory))
        .where((a) => a.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    final runbookCount = SampleRepository.getAllArticles().where((a) => a.type == 'runbook').length;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Morning, ops squad',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Stay ahead with curated playbooks & live runbooks.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(context, '/checklists'),
                            icon: const Icon(Icons.checklist_rtl, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(context, '/admin'),
                            icon: const Icon(Icons.settings, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      GlassPanel(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search playbooks, tags, keywords',
                                prefixIcon: Icon(Icons.search),
                              ),
                              onChanged: (value) => setState(() => search = value),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _DashboardStat(
                                    label: 'Pinned assets',
                                    value: pinned.length.toString(),
                                    trend: '${pinned.length} synced today',
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _DashboardStat(
                                    label: 'Active incidents',
                                    value: runbookCount.toString(),
                                    trend: '${recents.length} in review',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 42,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final c = categories[index];
                            return ChoiceChip(
                              label: Text(c),
                              selected: selectedCategory == c,
                              onSelected: (_) => setState(() => selectedCategory = c),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Pinned playbooks',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 190,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: pinned.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 14),
                          itemBuilder: (_, index) {
                            final p = pinned[index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/article', arguments: p.id),
                              child: Container(
                                width: 260,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.white.withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 24,
                                      offset: const Offset(0, 18),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        p.tags.join(' / '),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      p.title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Updated by ${p.lastUpdatedBy}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Recent activity',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: GlassPanel(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Column(
                      children: [
                        if (recents.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('No entries match your filters right now.'),
                          ),
                        ...recents.map(
                          (r) => ListTile(
                            onTap: () => Navigator.pushNamed(context, '/article', arguments: r.id),
                            title: Text(
                              r.title,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('${r.tags.join(' / ')} - Last edited by ${r.lastUpdatedBy}'),
                            trailing: const Icon(Icons.chevron_right_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      _QuickTile(icon: Icons.notification_important, label: 'On-call timeline'),
                      _QuickTile(icon: Icons.auto_awesome_motion, label: 'Automation queue'),
                      _QuickTile(icon: Icons.data_usage, label: 'Usage analytics'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, '/library');
              break;
            case 2:
              Navigator.pushNamed(context, '/runbooks');
              break;
            case 3:
              Navigator.pushNamed(context, '/checklists');
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.bolt), label: 'Runbooks'),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), label: 'Checklists'),
        ],
      ),
    );
  }
}

class _DashboardStat extends StatelessWidget {
  const _DashboardStat({
    required this.label,
    required this.value,
    required this.trend,
  });

  final String label;
  final String value;
  final String trend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(trend, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.greenAccent)),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
