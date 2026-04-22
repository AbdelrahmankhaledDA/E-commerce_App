import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/cart/data/models/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failures, CartModel>> getCart(String? userToken);
  Future<Either<Failures, CartModel>> addToCart(int productId, int quantity);
  Future<Either<Failures, CartModel>> removeFromCart(
    int cartId,
    List<Map<String, dynamic>> updatedProducts,
  );
}
