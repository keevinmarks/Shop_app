import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerCart = Provider.of<Cart>(context, listen: true);
    //Para acessar a parte dos valores de um mapa, basta adicionar .values no final, e depois converter para uma lista com o generic correspondente
    final List<CartItem> cartListItems = providerCart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de compras"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),

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
                      "R\$${providerCart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  if (!(providerCart.itemsCount <= 0))
                    TextButton(
                      onPressed: () {
                        if (!(providerCart.itemsCount <= 0)) {
                          Provider.of<OrderList>(
                            context,
                            listen: false,
                          ).addOrder(providerCart);
                          providerCart.clear();
                        }
                      },
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
