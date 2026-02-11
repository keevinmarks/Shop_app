import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:shop/providers/counter.dart';
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
    return ChangeNotifierProvider(
      create: (ctx) => ProductList(),
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
          AppRouters.PRODUCT_DETAIL: (ctx) => CounterPage(),
        },
      ),
    );
  }
}
