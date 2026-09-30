import 'package:flutter/foundation.dart';

/// Lightweight in-memory store for favorited poses.
///
/// This is intentionally local-only for now — persistence can be added
/// later without touching the UI.
class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();

  static final FavoritesStore instance = FavoritesStore._();

  final Set<String> _ids = <String>{};

  bool isFavorite(String id) => _ids.contains(id);

  void toggle(String id) {
    if (!_ids.remove(id)) {
      _ids.add(id);
    }
    notifyListeners();
  }

  List<String> get ids => _ids.toList(growable: false);
}
