import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/sample_repo.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  String search = '';
  final categories = ['Networking', 'Cloud', 'Security', 'Systems', 'Runbooks'];
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final pinned = SampleRepository.pinned();
    final recents = SampleRepository.recents();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 140,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text("IT's Handbook", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              background: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 56),
                alignment: Alignment.bottomCenter,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search playbooks, tags, keywords',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  onChanged: (v) => setState(() => search = v),
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () => Navigator.pushNamed(context, '/checklists'), icon: const Icon(Icons.checklist_rtl)),
              IconButton(onPressed: () => Navigator.pushNamed(context, '/admin'), icon: const Icon(Icons.settings)),
            ],
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 64,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemBuilder: (context, i) {
                  final c = i == 0 ? 'All' : categories[i - 1];
                  final selected = c == selectedCategory;
                  return ChoiceChip(
                    label: Text(c),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedCategory = c),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: categories.length + 1,
              ),
            ),
          ),

          // Pinned grid
          if (pinned.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Pinned', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 3,
                    children: pinned.map((p) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/article', arguments: p.id),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(child: Text(p.title)),
                                const Icon(Icons.bookmark_border),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
              ),
            ),

          // Recents
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Recent', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...recents.map((r) => Card(child: ListTile(title: Text(r.title), subtitle: Text('${r.tags.join(' · ')} • ${r.lastUpdatedBy}'), onTap: () => Navigator.pushNamed(context, '/article', arguments: r.id)))),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              break; // already home
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
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.medical_services), label: 'Runbooks'),
          NavigationDestination(icon: Icon(Icons.checklist_rtl), label: 'Checklists'),
        ],
      ),
    );
  }
}
