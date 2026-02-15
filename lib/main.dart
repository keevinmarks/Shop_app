import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:shop/utils/routers.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Envolvendo toda a aplicação no CounterProvider, basicamente todos tem acesso
    //return CounterProvider(

    //Envolvendo tudo nesse novo Provider nativo
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (ctx) => OrderList(),)
      ],
      //Aqui é onde criamos o provider que vai disponiblizar a lista de produtos para toda a aplicação
      //Nessa caso estamos usando o create pois queremos criar uma nova instância do ProductList, ou seja, uma nova lista de produtos
      child: MaterialApp(
        title: "Shop App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
          fontFamily: "Lato",
        ),
        //home: ProductOverviewPage(),
        routes: {
          AppRouters.HOME: (ctx) => ProductOverviewPage(),
          AppRouters.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRouters.CART: (ctx) => CartPage(),
          AppRouters.ORDERS: (ctx) => OrdersPage()
        },
      ),
    );
  }
}
