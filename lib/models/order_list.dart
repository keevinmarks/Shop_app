import 'dart:math';

import 'package:flutter/material.dart';
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

  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
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
