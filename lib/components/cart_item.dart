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
      //O confirmDimiss retorna um Future<bool>
      confirmDismiss: (_) {
        //Componente que retorna um Future<T>
        return showDialog<bool>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Tem certeza ?"),
              content: Text("Quer mesmo remover isso item do carrinho"),
              actions: [
                TextButton(
                  child: Text("Não"),
                  onPressed: () {
                    //Passando um valor ao fechar destruir componente
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    //Passando um valor ao fechar destruir componente
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
      },
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
