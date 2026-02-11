import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/routers.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Product>(context);
    final Product product = provider;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
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

            Navigator.of(context).pushNamed(AppRouters.PRODUCT_DETAIL, arguments: product);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
