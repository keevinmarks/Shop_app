import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routers.dart';

class ProductPage extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadingProducts();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = Provider.of<ProductList>(context).items;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouters.PRODUCTS_FORM);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  ProductItem(productList[index]),
                  Divider(height: 1, color: Colors.grey.shade400),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
