import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/models/response_products_model.dart';
import 'package:e_commerceapp/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiService apiservice;
  HomeRepoImpl(this.apiservice);
  @override
  Future<Either<Failures, ResponseProductsModel>> getAllProducts() async {
    try {
      final response = await apiservice.get(
        "https://dummyjson.com/products",
        headers: {},
      );
      return Future.value(Right(ResponseProductsModel.fromJson(response)));
    } catch (e) {
      print("FULL ERROR DETAILS: $e");
      if (e is DioException) {
        return Future.value(Left(ServerFailures.fromDioException(e)));
      }
      return Future.value(left(ServerFailures(e.toString())));
    }
  }
}
