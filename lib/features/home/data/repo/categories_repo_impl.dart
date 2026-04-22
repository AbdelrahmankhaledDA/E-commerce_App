import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/repo/categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  ApiService apiService;
  CategoriesRepoImpl(this.apiService);
  @override
  Future<Either<Failures, List<String>>> getAllCategories() async {
    try {
      final response = await apiService.get(
        "https://dummyjson.com/products/category-list",
      );
      return Future.value(Right(List<String>.from(response)));
    } catch (e) {
      // هنا نستخدم الـ Failures التي عرفتها مسبقاً
      if (e is DioException) {
        return Future.value(Left(ServerFailures.fromDioException(e)));
      }
      return Future.value(Left(ServerFailures(e.toString())));
    }
  }
}
