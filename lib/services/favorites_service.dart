import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  FavoritesService._private();
  static final FavoritesService instance = FavoritesService._private();

  static const _kFavoritesKey = 'its_favorites';
  static const _kRecentsKey = 'its_recents';

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<List<String>> getFavorites() async {
    await init();
    return _prefs?.getStringList(_kFavoritesKey) ?? [];
  }

  Future<bool> isFavorite(String id) async {
    final favs = await getFavorites();
    return favs.contains(id);
  }

  Future<void> toggleFavorite(String id) async {
    await init();
    final favs = _prefs!.getStringList(_kFavoritesKey) ?? [];
    if (favs.contains(id)) {
      favs.remove(id);
    } else {
      favs.add(id);
    }
    await _prefs!.setStringList(_kFavoritesKey, favs);
  }

  Future<List<String>> getRecents() async {
    await init();
    return _prefs?.getStringList(_kRecentsKey) ?? [];
  }

  /// Adds id to the front of recents, keeps unique and caps at 10
  Future<void> addRecent(String id) async {
    await init();
    final recents = _prefs!.getStringList(_kRecentsKey) ?? [];
    recents.remove(id);
    recents.insert(0, id);
    if (recents.length > 10) recents.removeRange(10, recents.length);
    await _prefs!.setStringList(_kRecentsKey, recents);
  }
}
