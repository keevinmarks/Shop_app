import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {"email": "", "password": ""};
  bool _isLoading = false;

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Ocorreu um erro"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    //Essa função valida os campos do formulário (retornando verdadeiro ou falso):
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);
    //Essa função executa a função onSaved do formulário em todos os campos
    _formKey.currentState?.save();

    final auth = Provider.of<Auth>(context, listen: false);
    try {
      if (isLogin()) {
        await auth.login(_authData["email"]!, _authData["password"]!);
      } else {
        await auth.signup(_authData["email"]!, _authData["password"]!);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print("Está entrando nesse catch");
      _showErrorDialog("Ocorreu um erro inesperado!");
      print(error);
    }

    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.Signup;
        _controller?.forward();
      } else {
        _authMode = AuthMode.Login;
        _controller?.reverse();
      }
    });
  }

  //Controle de animação
  AnimationController? _controller;

  //Animação
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  bool isLogin() => _authMode == AuthMode.Login;
  bool isSignup() => _authMode == AuthMode.Signup;

  @override
  void initState() {
    super.initState();

    //Construindo o controller de animação
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );


    //Definindo o heightAnimation
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    //Adicionado um listener para atualizar o build do widget
    //_heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        //height: _heightAnimation?.value.height ?? (isLogin() ? 310 : 400),
        height: isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData["email"] = email ?? "",
                validator: (valueEmail) {
                  final email = valueEmail ?? "";
                  if (email.trim().isEmpty) {
                    return "Informe um email";
                  } else if (!email.contains("@")) {
                    return "Informe um email válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Senha",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (password) => _authData["password"] = password ?? "",
                controller: _passwordController,
                validator: (valuePassword) {
                  final password = valuePassword ?? "";
                  if (password.isEmpty || password.length < 5) {
                    return "informe uma senha válida";
                  }

                  return null;
                },
              ),

              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: isLogin() ? 0 : 60,
                  maxHeight: isLogin() ? 0 : 120,
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirmar senha",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: isLogin()
                          ? null
                          : (valuePassword) {
                              final password = valuePassword ?? "";
                              if (password == _passwordController.text) {
                                return null;
                              } else {
                                return "As senha não conferem";
                              }
                            },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        _authMode == AuthMode.Login ? "ENTRAR" : "REGISTRAR",
                      ),
                    ),
              Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(isLogin() ? "Sign up" : "Login"),
              ),
            ],
          ),
        ),
      ),
      // child: AnimatedBuilder(
      //   animation: _heightAnimation!,
      //   builder: (ctx, childForm) => Container(
      //     height: _heightAnimation?.value.height ?? (isLogin() ? 310 : 400),
      //     width: deviceSize.width * 0.75,
      //     padding: const EdgeInsets.all(16),
      //     child: childForm,
      //   ),
      //   child: Form(
      //     key: _formKey,
      //     child: Column(
      //       children: [
      //         TextFormField(
      //           decoration: InputDecoration(
      //             labelText: "E-mail",
      //             enabledBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(color: Colors.grey),
      //             ),
      //           ),
      //           keyboardType: TextInputType.emailAddress,
      //           onSaved: (email) => _authData["email"] = email ?? "",
      //           validator: (valueEmail) {
      //             final email = valueEmail ?? "";
      //             if (email.trim().isEmpty) {
      //               return "Informe um email";
      //             } else if (!email.contains("@")) {
      //               return "Informe um email válido";
      //             }
      //             return null;
      //           },
      //         ),
      //         TextFormField(
      //           decoration: InputDecoration(
      //             labelText: "Senha",
      //             enabledBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(color: Colors.grey),
      //             ),
      //           ),
      //           keyboardType: TextInputType.emailAddress,
      //           obscureText: true,
      //           onSaved: (password) => _authData["password"] = password ?? "",
      //           controller: _passwordController,
      //           validator: (valuePassword) {
      //             final password = valuePassword ?? "";
      //             if (password.isEmpty || password.length < 5) {
      //               return "informe uma senha válida";
      //             }

      //             return null;
      //           },
      //         ),
      //         if (isSignup())
      //           TextFormField(
      //             decoration: InputDecoration(
      //               labelText: "Confirmar senha",
      //               enabledBorder: UnderlineInputBorder(
      //                 borderSide: BorderSide(color: Colors.grey),
      //               ),
      //             ),
      //             keyboardType: TextInputType.emailAddress,
      //             obscureText: true,
      //             validator: isLogin()
      //                 ? null
      //                 : (valuePassword) {
      //                     final password = valuePassword ?? "";
      //                     if (password == _passwordController.text) {
      //                       return null;
      //                     } else {
      //                       return "As senha não conferem";
      //                     }
      //                   },
      //           ),
      //         SizedBox(height: 20),
      //         _isLoading
      //             ? Center(child: CircularProgressIndicator())
      //             : ElevatedButton(
      //                 onPressed: _submit,
      //                 style: ElevatedButton.styleFrom(
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(30),
      //                   ),
      //                   padding: EdgeInsets.symmetric(
      //                     horizontal: 30,
      //                     vertical: 8,
      //                   ),
      //                 ),
      //                 child: Text(
      //                   _authMode == AuthMode.Login ? "ENTRAR" : "REGISTRAR",
      //                 ),
      //               ),
      //         Spacer(),
      //         TextButton(
      //           onPressed: _switchAuthMode,
      //           child: Text(isLogin() ? "Sign up" : "Login"),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
