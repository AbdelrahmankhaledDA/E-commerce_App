import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/core/storage/cach_helper.dart';
import 'package:e_commerceapp/features/cart/data/models/cart_model.dart';
import 'package:e_commerceapp/features/cart/data/models/cart_product_model.dart';
import 'package:e_commerceapp/features/cart/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cart) : super(CartInitial());
  CartRepo cart;
  String? token = CachHelper.gettoken(key: 'token');

  CartModel? currentCart;

  getCart() async {
    emit(CartLoading());
    if (token != null) {
      final result = await cart.getCart(token);
      result.fold((error) => emit(CartError(error.message)), (cartData) {
        currentCart = cartData;
        emit(CartSuccess(cartData));
      });
    } else {
      emit(CartError("Please login again."));
    }
  }

  addToCart(int productId, int quantity) async {
    emit(CartAdding());
    final result = await cart.addToCart(productId, quantity);
    result.fold((failure) => emit(CartAddFailure(failure.message)), (newCart) {
      currentCart = newCart;
      emit(CartAddedSuccess(newCart));
      emit(CartSuccess(newCart));
    });
  }

  deleteProduct(int productId) async {
    if (currentCart != null) {
      List<CartProductModel> remainingProducts = currentCart!.products
          .where((item) => item.id != productId)
          .toList();

      List<Map<String, dynamic>> updatedProductsMap = remainingProducts.map((
        e,
      ) {
        return {"id": e.id, "quantity": e.quantity};
      }).toList();

      final result = await cart.removeFromCart(1, updatedProductsMap);

      result.fold((failure) => emit(CartError(failure.message)), (newCart) {
        currentCart = newCart;
        emit(CartSuccess(newCart));
      });
    }
  }
}
