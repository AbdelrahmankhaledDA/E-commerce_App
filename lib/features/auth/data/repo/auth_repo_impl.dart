import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/auth/data/model/UserModels.dart';
import 'package:e_commerceapp/features/auth/data/repo/auth_repositry.dart';

class AuthRepoImpl implements AuthRepository {
  final ApiService apiService; // أضف final لضمان الأمان
  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failures, UserModels>> loginUserbyApi(
    String username,
    String password,
  ) async {
    try {
      final data = await apiService.post("https://dummyjson.com/auth/login", {
        'username': username,
        'password': password,
      });

      // تحويل البيانات لـ UserModel
      final user = UserModels.fromJson(data);

      return Right(user); // Dart ستفهم أنها Future<Either<...>> تلقائياً
    } catch (e) {
      // 💡 هذه الطباعة ستكشف لك المستور في الـ Debug Console
      print("Error in AuthRepoImpl: ${e.toString()}");

      if (e is DioException) {
        return left(ServerFailures.fromDioException(e));
      }
      return left(ServerFailures(e.toString()));
    }
  }

  Future<Either<Failures, UserModels>> registerByApi(
    String username,
    String email,
    String password,
  ) async {
    try {
      final data = await apiService.post('https://dummyjson.com/users/add', {
        'username': username,
        'email': email,
        'password': password,
      });
      final user = UserModels.fromJson(data as Map<String, dynamic>);
      return Future.value(Right(user));
    } catch (e) {
      if (e is DioException) {
        return Future.value(Left(ServerFailures.fromDioException(e)));
      }
      return Future.value(left(ServerFailures(e.toString())));
    }
  }
}
