import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routers.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRouters.PRODUCTS_FORM, arguments: product);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Tem certeza disso ?"),
                      content: Text("Confirme a exlusão do produto"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<ProductList>(
                              context, listen: false
                            ).removeProduct(product);
                            Navigator.of(context).pop();
                          },
                          child: Text("Confirmar"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
