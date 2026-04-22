import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failures, List<ProductModel>>> getProductsByCategory(
    String categorySlug,
  );
}
