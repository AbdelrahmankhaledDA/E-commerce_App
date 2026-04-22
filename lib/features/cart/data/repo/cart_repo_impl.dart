import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/cart/data/models/cart_model.dart';
import 'package:e_commerceapp/features/cart/data/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  ApiService apiservice;
  CartRepoImpl(this.apiservice);
  @override
  Future<Either<Failures, CartModel>> getCart(String? userToken) async {
    try {
      final response = await apiservice.get(
        "https://dummyjson.com/carts",
        headers: {'Authorization': 'Bearer $userToken'},
      );
      return Future.value(Right(CartModel.fromJson(response['carts'][0])));
    } catch (e) {
      if (e is DioException) {
        return Future.value(left(ServerFailures.fromDioException(e)));
      }
      return Future.value(left(ServerFailures(e.toString())));
    }
  }

  @override
  Future<Either<Failures, CartModel>> addToCart(
    int productId,
    int quantity,
  ) async {
    try {
      final data = await apiservice.post("https://dummyjson.com/carts/add", {
        "userId": 1,
        "products": [
          {"id": productId, "quantity": quantity},
        ],
      });

      return Right(CartModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        print("Dio Error Data: ${e.response?.data}");
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  Future<Either<Failures, CartModel>> removeFromCart(
    int cartId,
    List<Map<String, dynamic>> updatedProducts,
  ) async {
    try {
      final data = await apiservice.put("https://dummyjson.com/carts/$cartId", {
        "merge": false,
        "products": updatedProducts,
      });
      return Right(CartModel.fromJson(data));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
