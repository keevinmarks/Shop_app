class AuthException implements Exception {
  Map<String, String> errors = {
    "EMAIL_EXISTS": "Email já cadastrado",
    "OPERATION_NOT_ALLOWED": "Operção não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Muitas tentativas, tente novamente mais tarde",
    "INVALID_LOGIN_CREDENTIALS": "Credenciais inválidas",
    "USER_DISABLED": "Usuário desabilitado",
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    // TODO: implement toString
    return errors[key] ?? "Ocorreu um erro na autenticação";
  }

}
