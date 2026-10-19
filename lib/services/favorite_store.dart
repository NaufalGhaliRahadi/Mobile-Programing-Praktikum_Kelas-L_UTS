import 'package:flutter/foundation.dart';

/// Penyimpanan favorit sederhana di memori (hilang saat aplikasi ditutup).
class FavoriteStore {
  FavoriteStore._();

  static final ValueNotifier<Set<int>> ids = ValueNotifier<Set<int>>({});

  static bool isFavorite(int id) => ids.value.contains(id);

  static void toggle(int id) {
    final next = {...ids.value};
    if (!next.remove(id)) next.add(id);
    ids.value = next;
  }
}
