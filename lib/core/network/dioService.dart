import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService implements ApiService {
  final Dio _dio;
  DioService(this._dio) {
    _dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }
  @override
  Future post(String url, Map<String, dynamic> body, {Options? options}) async {
    try {
      final response = await _dio.post(url, data: body, options: options);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.put(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.delete(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
