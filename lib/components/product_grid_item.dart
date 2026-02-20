import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/routers.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Pegando provider do produto, ou seja, o item da lista de produtos
    final providerProduct = Provider.of<Product>(context, listen: false);
    final providerCart = Provider.of<Cart>(context, listen: false);
    //Deixando o listen como false, o provider não será mais atualizado quando o produto for atualizado, ou seja, quando o isFavorite for alterado, o widget não será reconstruído, apenas o widget que tem o provider do produto como pai, ou seja, o ProductGrid, será reconstruído, mas ainda é possivel utilizar o provider para acessar os dados do produto, como o title, imageUrl, etc, mas não será possível acessar o isFavorite, pois ele não será atualizado, ou seja, não será reconstruído quando o isFavorite for alterado
    final Product product = providerProduct;
    final Cart cart = providerCart;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //Consumer gera um widget que escuta as mudanças do provider, ou seja, quando o isFavorite for alterado, apenas o widget dentro do builder será reconstruído, ou seja, apenas o IconButton será reconstruído, e não todo o GridTileBar
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleIsFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);

              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Row(
                    children: [
                      Text("Produto adicionado com sucesso"),
                      TextButton(
                        child: Text(
                          "DESFAZER",
                          style: TextStyle(color: Colors.orange.shade600),
                        ),
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ],
                  ),
                  // action: SnackBarAction(
                  //   label: "DESFAZER",
                  //   onPressed: () {
                  //     cart.removeSingleItem(product.id);
                  //   },
                  // ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailPage(),
            //   ),
            // );

            Navigator.of(
              context,
            ).pushNamed(AppRouters.PRODUCT_DETAIL, arguments: product);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
