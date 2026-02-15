import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(  
      key: ValueKey(cartItem.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text("${cartItem.price}")),
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text("Total: R\$${cartItem.price * cartItem.quantity}"),
            trailing: Text("${cartItem.quantity}x"),
          ),
        ),
      ),
    );
  }
}
