import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:e_commerceapp/features/home/data/repo/product_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiService apiService;

  ProductRepoImpl(this.apiService);

  @override
  Future<Either<Failures, List<ProductModel>>> getProductsByCategory(
    String categorySlug,
  ) async {
    try {
      final result = await apiService.get(
        'https://dummyjson.com/products/category/$categorySlug',
      );

      final productsJson = result['products'] as List;

      List<ProductModel> products = productsJson
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Future.value(Right(products));
    } catch (e) {
      if (e is DioException) {
        return Future.value(Left(ServerFailures.fromDioException(e)));
      }
      return Future.value(Left(ServerFailures(e.toString())));
    }
  }
}
