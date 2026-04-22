import 'package:dartz/dartz.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/home/data/models/response_products_model.dart';
import 'package:e_commerceapp/features/search/data/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  ApiService apiservice;
  SearchRepoImpl(this.apiservice);

  @override
  Future<Either<Failures, ResponseProductsModel>> searchProduct(
    String query,
  ) async {
    try {
      final data = await apiservice.get(
        'https://dummyjson.com/products/search',
        queryParameters: {"q": query},
      );
      print('Searched products: $data');
      return Right(ResponseProductsModel.fromJson(data));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
