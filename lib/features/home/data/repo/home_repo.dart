import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/models/response_products_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, ResponseProductsModel>> getAllProducts();
}
