import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoritesItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> loadingProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse("${Constants.PRODUCTS_BASE_URL}.json"));
    if (response.body == "null") return;
    Map<String, dynamic> responseData = jsonDecode(response.body);
    responseData.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData["name"],
          description: productData["description"],
          price: productData["price"],
          imageUrl: productData["imageUrl"],
          isFavorite: productData["isFavorite"],
        ),
      );
    });
    notifyListeners();
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

  // Future<void> updateFavorite(Product product) async {
  //   if (_items.contains(product)) {
  //     final response = await http.patch(
  //       Uri.parse("${Constants.PRODUCTS_BASE_URL}/${product.id}.json"),
  //       body: jsonEncode({"isFavorite": product.isFavorite}),
  //     );
      

  //     if(response.statusCode >= 400){
  //       throw HttpException(msg: "Ocorreu um erro ao favoritar", httpCode: response.statusCode);
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    await http.patch(
      Uri.parse("${Constants.PRODUCTS_BASE_URL}/${product.id}.json"),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  //Métodos assincronos precisam retornar Futures<>
  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse("${Constants.PRODUCTS_BASE_URL}.json"),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
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
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      Product productBackup = _items[index];
      _items.remove(productBackup);
      final response = await http.delete(Uri.parse("${Constants.PRODUCTS_BASE_URL}/${product.id}.json"));
      if (response.statusCode >= 400) {
        _items.insert(index, productBackup);
        notifyListeners();
        throw HttpException(
          msg: "Não foi possível excluir o produto",
          httpCode: response.statusCode,
        );
      }
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
