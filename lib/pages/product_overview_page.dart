import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/utils/routers.dart';

enum FilterOptions { All, Favorites }

class ProductOverviewPage extends StatefulWidget {
  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text("Produtos"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(value: FilterOptions.All, child: Text("Todos")),
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text("Somente favoritos"),
              ),
            ],
            onSelected: (FilterOptions selectedItem) {
              setState(() {
                if (selectedItem == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouters.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) {
              return BadgeShopping(
                value: cart.itemsCount.toString(),
                child: child!,
              );
            },
          ),
        ],
      ),
      body: ProductGrid(_showFavoritesOnly),
    );
  }
}
