import 'package:e_commerceapp/core/server_locator/server_locator.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerceapp/features/payment/repo/payment_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: Text(state.error));
          }
          if (state is CartSuccess) {
            return Column(
              children: [
                Text("Your Cart"),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.products.length,

                    itemBuilder: (context, index) {
                      final product = state.cart.products[index];
                      return ListTile(
                        leading: Image.network(
                          state.cart.products[index].thumbnail ?? "",
                          width: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                        title: Text("${state.cart.products[index].title}"),
                        subtitle: Text("${state.cart.products[index].price}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<CartCubit>().deleteProduct(
                              product.id!,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Text("Total price ${state.cart.total}"),
                Text("Total products ${state.cart.totalProducts}"),
                PrimayButtonWidget(
                  onPress: () async {
                    await getIt<PaymentRepo>().makePayment(
                      state.cart.total!.toInt(),
                      "usd",
                    );
                  },
                  buttonText: "Finalize Purchase ",
                ),
              ],
            );
          }
          return Text("No Items");
        },
      ),
    );
  }
}
