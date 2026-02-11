import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Pegando primeiro o provider;
    final provider = Provider.of<ProductList>(context);


    //Carregando dados do provider
    final loadingProducts = provider.items;

    return Scaffold(
      appBar: AppBar(title: Text("Produtos"), centerTitle: true),
      body: GridView.builder(
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
          return ProductItem(product: loadingProducts[index]);
        },
      ),
    );
  }
}
