import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  //Product product;
  //ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(product.name),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue.shade200,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                "R\$${product.price}",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(product.description, textAlign: TextAlign.center),
              ),
            ]),
          ),
        ],
        // child: Column(
        //   children: [
        //     Container(
        //       height: 300,
        //       width: double.infinity,
        //       child: Hero(
        //         tag: product.id,
        //         child: Image.network(product.imageUrl, fit: BoxFit.cover),
        //       ),
        //     ),
        //     SizedBox(height: 10),
        //     Text(
        //       "R\$${product.price}",
        //       style: TextStyle(fontSize: 20, color: Colors.grey),
        //     ),
        //     SizedBox(height: 10),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       child: Text(product.description, textAlign: TextAlign.center),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
