import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final provider = Provider.of<ProductList>(context);

    final loadingProducts = provider.items;

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
          return ChangeNotifierProvider(
            create: (_) => loadingProducts[index],
            child: ProductGrid(),
          );
        },
      );
  }
}