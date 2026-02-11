import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  //Product product;
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;

    final provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Counter page"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text(provider?.state.value.toString() as String),
            SizedBox(height: 10),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.state.inc();
                });
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.state.dec();
                });
              },
              icon: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
