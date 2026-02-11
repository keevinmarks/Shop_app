import 'package:flutter/material.dart';

//Classe para vai ser instaciada o State
class CounterState {
  //Valores que serão utilizados
  int _value = 0;

  //Metodos para fazer a alteração do estado
  void inc() => _value++;
  void dec() => _value--;

  //Getter para pegar o value
  int get value => _value;

  //Função que verifica se o estado anterior é igual ao atual
  bool diff(CounterState old) {
    print("Valor antigo ${old._value}");
    print("Valor novo ${_value}");
    return old._value != _value;
  }
}

//Classe extendendo o InheritedWidget
class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  //Construtor de um provider, precisa receber um parâmetro filha 
  CounterProvider({required Widget child}) : super(child: child);


  //Função para ser possível acessar atributos e métodos do provider
  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  //Função q vai disparar uma notificação para o Widget ser recarregado, pois houve uma alteração
  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
