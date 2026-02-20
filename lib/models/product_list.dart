import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final String _baseUrl = "https://shop-app-6afed-default-rtdb.firebaseio.com";
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoritesItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data["id"] != null;

    final product = Product(
      id: hasId ? data["id"] as String : Random().nextDouble().toString(),
      name: data["name"] as String,
      description: data["description"] as String,
      price: data["price"] as double,
      imageUrl: data["imageUrl"] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product product) {
    final future = http.post(
      Uri.parse("$_baseUrl/product.json"),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    return future
        .then((resp) {
          final id = jsonDecode(resp.body)['name'];

          _items.add(
            Product(
              id: id,
              name: product.name,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl,
              isFavorite: product.isFavorite,
            ),
          );
          //Adicionando um evento de listeners de notificação para quando o state mudar
          notifyListeners();
        })
        .catchError((error) {
          print(error.toString());
          throw error;
        });
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
    }
    notifyListeners();
  }
}

  // bool _showFavoritesOnly = false;

  // List<Product> get items {
  //   if (_showFavoritesOnly) {
  //     return _item.where((product) => product.isFavorite).toList();
  //   } else {
  //     return [..._item];
  //   }
  // }

  // void showFavoriteOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
