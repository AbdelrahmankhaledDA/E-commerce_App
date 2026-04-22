import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';

import 'package:e_commerceapp/features/home/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  ProductByCategoryCubit(this.products) : super(ProductByCategoryInitial());
  ProductRepo products;
  Future<void> getProductByCat(String categorySlug) async {
    emit(ProductByCategoryLoading());

    final result = await products.getProductsByCategory(categorySlug);
    result.fold(
      (error) => emit(ProductByCategoryError(error.message)),
      (result) => emit(ProductByCategorySuccess(result)),
    );
  }
}
