part of 'product_by_category_cubit.dart';

@immutable
sealed class ProductByCategoryState {}

final class ProductByCategoryInitial extends ProductByCategoryState {}

final class ProductByCategoryLoading extends ProductByCategoryState {}

final class ProductByCategorySuccess extends ProductByCategoryState {
  final List<ProductModel> products;
  ProductByCategorySuccess(this.products);
}

final class ProductByCategoryError extends ProductByCategoryState {
  final String error;
  ProductByCategoryError(this.error);
}
