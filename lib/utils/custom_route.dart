import 'package:flutter/material.dart';

//Criando uma transição para ser usada em rotas específicas
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, RouteSettings? settings})
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == "/") {
      return child;
    }
    return FadeTransition(opacity: animation, child: child);
  }
}

//Criando uma custom Transition para ser usada de forma global no materalApp
class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == "/") {
      return child;
    }

    return FadeTransition(opacity: animation, child: child);
  }
}
