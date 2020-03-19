import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  //* methods

  void _setFavValue(bool newVal) {
    isFavourite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavourite() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    final url = 'https://shopping-app-cce51.firebaseio.com/products/$id.json';
    notifyListeners();
    try {
      final response = await http.patch(url,
          body: json.encode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
