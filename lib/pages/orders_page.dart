import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Meus pedidos"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      //Dentro de um Future builder é possível tratar característica de um processo assincrono, como verificar o tempo e erros
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadingOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text("Ocorreu um erro ao carregar pedidos"));
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.orders.length,
                itemBuilder: (ctx, index) {
                  return OrderItem(order: orders.orders[index]);
                },
              ),
            );
          }
        },
      ),
      // body: isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     : orders.orders.isEmpty
      //     ? Center(child: Text("Você não tem pedidos no momento"))
      //     : ListView.builder(
      //         itemCount: orders.orders.length,
      //         itemBuilder: (ctx, index) {
      //           return OrderItem(order: orders.orders[index]);
      //         },
      //       ),
    );
  }
}
