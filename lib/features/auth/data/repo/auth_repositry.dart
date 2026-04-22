import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/auth/data/model/UserModels.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserModels>> loginUserbyApi(
    String username,
    String password,
  );
  Future<Either<Failures, UserModels>> registerByApi(
    String username,
    String email,
    String password,
  );
}
