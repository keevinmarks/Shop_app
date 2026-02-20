import 'package:flutter/material.dart';
import 'package:shop/utils/routers.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).pushReplacementNamed(AppRouters.HOME);
            },
          ),
          Divider(height: 1, color: Colors.grey.shade300,),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.ORDERS);
            },
          ),
          Divider(height: 1, color: Colors.grey.shade300,),
          ListTile(
            leading: Icon(Icons.create),
            title: Text("Produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
