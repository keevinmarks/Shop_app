import 'package:flutter/material.dart';
import 'package:shop/utils/routers.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text("Bem vindo Usuário"), centerTitle: true, automaticallyImplyLeading: false,),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Loja"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.HOME);
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouters.ORDERS);
            },
          ),
        ],
      ),
    );
  }
}
