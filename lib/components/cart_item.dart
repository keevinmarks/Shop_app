import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    // final Cart cartProvider = Provider.of(context);
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      key: Key(cartItem.id),
      direction: DismissDirection.startToEnd,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            subtitle: Text("Total: R\$${cartItem.price * cartItem.quantity}"),
            title: Text(cartItem.name),
            trailing: Text("${cartItem.quantity}x"),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text("${cartItem.price}")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
