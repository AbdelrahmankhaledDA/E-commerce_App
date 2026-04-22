import 'package:dio/dio.dart';
abstract class Failures {
  final String message;
  Failures(this.message);
}
class ServerFailures extends Failures{
  ServerFailures(super.message);
  factory ServerFailures.fromDioException(DioException e){
    switch(e.type){
      case DioExceptionType.connectionTimeout:
        return ServerFailures("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ServerFailures("Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ServerFailures("Receive timeout with API server");
      case DioExceptionType.badCertificate:
        return ServerFailures("Bad certificate with API server");
      case DioExceptionType.badResponse:
        return ServerFailures("Bad response with API server");
      case DioExceptionType.cancel:
        return ServerFailures("Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return ServerFailures("Connection error with API server");
      case DioExceptionType.unknown:
        return ServerFailures("Unexpected error, please try again!");
        default:
          return ServerFailures("Unexpected error, please try again!");
    }

  }

}
