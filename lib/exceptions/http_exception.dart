class HttpException implements Exception{
  final String msg;
  final int httpCode;

  HttpException({
    required this.msg,
    required this.httpCode
  });


  @override
  String toString(){
    return msg;
  } 
}