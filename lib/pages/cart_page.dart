import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerCart = Provider.of<Cart>(context,);

    //Para acessar a parte dos valores de um mapa, basta adicionar .values no final, e depois converter para uma lista com o generic correspondente
    final List<CartItem> cartListItems = providerCart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Carrinho de compras"), centerTitle: true),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(
              vertical: 25, horizontal: 15
            ),

            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Colors.blue,
                    label: Text(
                      "R\$${providerCart.totalAmount}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.purple),
                    ),
                    child: Text("COMPRAR"),
                  ),
                ],
              ),
            ),
          ),

          //Aqui o Expanded ajudou por que o ListView.builder precisa que seu Widget pai tenha tamanho definido
          Expanded(
            child: ListView.builder(
              itemCount: cartListItems.length,
              itemBuilder: (ctx, index) {
                return CartItemWidget(cartItem: cartListItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
