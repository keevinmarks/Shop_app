import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  bool showFavoritesOnly;
  ProductGrid(this.showFavoritesOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    final loadingProducts = showFavoritesOnly
        ? provider.favoritesItems
        : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: loadingProducts.length,
      //padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, index) {
        //Agora usamos o provider com value, pois queremos passar um valor já existente, ou seja, o produto da lista
        return ChangeNotifierProvider.value(
          //Criando um provider para cada item da lista, ou seja, cada produto
          value: loadingProducts[index],
          child: ProductItem(),
        );
      },
    );
  }
}
