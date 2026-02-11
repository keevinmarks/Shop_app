import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _item = dummyProducts;

  List<Product> get items => [..._item];

  void addProduct(Product product) {
    _item.add(product);

    //Adicionando um evento de listeners de notificação para quando o state mudar  
    notifyListeners();
  }
}
