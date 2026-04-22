import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/failures.dart';

abstract class CategoriesRepo {
  Future<Either<Failures, List<String>>> getAllCategories();
}
