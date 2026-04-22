import 'package:dio/dio.dart';

abstract class ApiService {
  Future<dynamic> post(
    String url,
    Map<String, dynamic> body, {
    Options? options,
  });

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  Future<dynamic> put(String url, Map<String, dynamic> body);

  Future<dynamic> delete(String url, Map<String, dynamic> body);
}
