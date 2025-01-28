import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  // state
  final Map<String, bool> _favourites = {};

  // getter
  Map<String, bool> get favourites => _favourites;

  // toggle favourites
  void toggleFavorites(String productId) {
    if (_favourites.containsKey(productId)) {
      _favourites[productId] = !_favourites[productId]!;
    } else {
      _favourites[productId] = true;
    }
    notifyListeners();
  }

  // methode to check wether the favourite or not
  bool isFavorite(String productId) {
    return _favourites[productId] ?? false;
  }
}
