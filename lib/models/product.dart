import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/exceptions/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleIsFavorite() async {
    _toggleIsFavorite();
      final response = await http.patch(
        Uri.parse("${Constants.PRODUCTS_BASE_URL}/$id.jsn"),
        body: jsonEncode({"isFavorite": isFavorite}),
      );
      if (response.statusCode >= 400) {
        _toggleIsFavorite();
        throw HttpException(
          msg: "Ocorreu um erro ao marcar favorito",
          httpCode: response.statusCode,
        );
      }
    
  }
}
