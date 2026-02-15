import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Meus pedidos"), centerTitle: true),
      body: orders.orders.isEmpty
          ? Center(
              child: Text(
                "Você não tem pedidos no momento",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, index) {
                return OrderItem(order: orders.orders[index]);
              },
            ),
    );
  }
}
