import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  Future<void> loadingOrders() async {
    _orders.clear();
    final response = await http.get(
      Uri.parse("${Constants.ORDERS_BASE_URL}.json"),
    );

    if (response.body == "null") return;
    Map<String, dynamic> responseData = jsonDecode(response.body);

    print(responseData);
    responseData.forEach((idOrder, orderData) {
      _orders.add(
        Order(
          id: idOrder,
          total: orderData["total"],
          products: (orderData["products"] as List<dynamic>).map((item) {
            return CartItem(
              id: item["id"],
              productId: item["productId"],
              name: item["name"],
              quantity: item["quantity"],
              price: item["price"],
            );
          }).toList(),
          date: DateTime.parse(orderData["date"]),
        ),
      );
    });

    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("${Constants.ORDERS_BASE_URL}.json"),
      body: jsonEncode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map(
              (cartItem) => {
                "id": cartItem.id,
                "productId": cartItem.productId,
                "name": cartItem.name,
                "quantity": cartItem.quantity,
                "price": cartItem.price,
              },
            )
            .toList(),
      }),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: "Ocorreu um erro ao tentar fazer pedido",
        httpCode: response.statusCode,
      );
    }

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
