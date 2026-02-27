import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/utils/custom_route.dart';
import 'package:shop/utils/routers.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Bem vindo Usuário"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Loja"),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRouters.AUTH_OR_HOME);
            },
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.ORDERS);
              // Navigator.of(
              //   context,
              // ).pushReplacement(CustomRoute(builder: (ctx) => OrdersPage()));
            },
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          ListTile(
            leading: Icon(Icons.create),
            title: Text("Produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.PRODUCTS);
            },
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sair"),
            onTap: () async {
              await auth.logout();
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRouters.AUTH_OR_HOME);
            },
          ),
        ],
      ),
    );
  }
}
