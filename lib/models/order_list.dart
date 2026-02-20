import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  Future<void> addOrder(Cart cart) async{
    final date = DateTime.now();
    final response = await http.post(Uri.parse("${Constants.ORDERS_BASE_URL}/orders.json"), body: 
    jsonEncode({
      "total": cart.totalAmount,
      "date": date.toIso8601String(),
      "products": cart.items.values.map((cartItem) => {
        "id": cartItem.id,
        "productId": cartItem.productId,
        "name": cartItem.name,
        "quantity": cartItem.quantity,
        "price": cartItem.price
      })
    }));

    final id = jsonDecode(response.body)["name"];
    _orders.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeOrder(Order order) {
    _orders.remove(order);
    notifyListeners();
  }
}
