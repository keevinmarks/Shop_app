import 'package:flutter/material.dart';

class Auth with ChangeNotifier {

  static const _url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]";
  Future<void> signup() async {
    final response = await post(U)
  }
}