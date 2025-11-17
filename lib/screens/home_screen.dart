import 'package:flutter/material.dart';
import '../widgets/search_bar.dart' as custom_search;
import '../widgets/playbook_card.dart';
import '../services/local_data_service.dart';
import '../services/favorites_service.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalDataService _dataService = LocalDataService.instance;
  final FavoritesService _favService = FavoritesService.instance;
  bool _loading = true;
  Set<String> _favorites = {};
  List<String> _recents = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _dataService.load();
    await _favService.init();
    final favs = await _favService.getFavorites();
    final rec = await _favService.getRecents();
    setState(() {
      _favorites = favs.toSet();
      _recents = rec;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iTs Handbook')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  custom_search.SearchBar(),
                  SizedBox(height: 16),
                  Text('Pinned Playbooks', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 16),
                  // Pinned playbooks (first 3 for demo)
                  Column(
                    children: _dataService.articles.take(3).map((a) {
                      final isFav = _favorites.contains(a.id);
                      return PlaybookCard(
                        id: a.id,
                        title: a.title,
                        subtitle: a.type + ' • ' + a.tags.join(', '),
                        isFavorite: isFav,
                        onTap: () async {
                          // open article
                          Navigator.of(context).pushNamed('/article', arguments: {'id': a.id});
                          await _favService.addRecent(a.id);
                        },
                        onFavoriteToggle: () async {
                          await _favService.toggleFavorite(a.id);
                          final favs = await _favService.getFavorites();
                          setState(() => _favorites = favs.toSet());
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 16),
                  Text('Common Runbooks', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 8),
                  Column(
                    children: _dataService.articles.where((a) => a.type == 'runbook').map((a) {
                      final isFav = _favorites.contains(a.id);
                      return PlaybookCard(
                        id: a.id,
                        title: a.title,
                        subtitle: a.tags.join(', '),
                        isFavorite: isFav,
                        onTap: () async {
                          Navigator.of(context).pushNamed('/article', arguments: {'id': a.id});
                          await _favService.addRecent(a.id);
                        },
                        onFavoriteToggle: () async {
                          await _favService.toggleFavorite(a.id);
                          final favs = await _favService.getFavorites();
                          setState(() => _favorites = favs.toSet());
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 16),
                  Text('Recents', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 8),
                  Column(
                    children: _recents.map((id) {
                      final article = _dataService.articles.firstWhere((a) => a.id == id, orElse: () => _dataService.articles.first);
                      final isFav = _favorites.contains(article.id);
                      return PlaybookCard(
                        id: article.id,
                        title: article.title,
                        subtitle: article.type,
                        isFavorite: isFav,
                        onTap: () {
                          Navigator.of(context).pushNamed('/article', arguments: {'id': article.id});
                        },
                        onFavoriteToggle: () async {
                          await _favService.toggleFavorite(article.id);
                          final favs = await _favService.getFavorites();
                          setState(() => _favorites = favs.toSet());
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
