import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _item = dummyProducts;

  List<Product> get items {
    return [..._item];
  }

  List<Product> get favoritesItems {
    return _item.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product product) {
    _item.add(product);

    //Adicionando um evento de listeners de notificação para quando o state mudar
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
