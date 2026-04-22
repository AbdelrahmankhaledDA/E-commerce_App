import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/styling/app_styles.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/core/widgets/SpacingWidgets.dart';
import 'package:e_commerceapp/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartCubit>().getCart();
              GoRouter.of(context).push(RouterGeneration.cartscreen);
            },
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(20),
                  Container(
                    width: 341.w,
                    height: 341.h,
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail ?? "",
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    product.title ?? "",
                    style: AppStyles.black16w500Style.copyWith(fontSize: 24.sp),
                  ),
                  const HeightSpace(8),
                  Text(
                    product.description ?? "",
                    style: AppStyles.grey12MediumStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const HeightSpace(150),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Divider(),
                  HeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: AppStyles.grey12MediumStyle.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          HeightSpace(4),
                          Text(
                            "${product.price} \$",
                            style: AppStyles.black16w500Style.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartAddedSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Added To Cart Successfully ${state.cart.products.last.title}",
                            ),
                          ),
                        );
                      }
                      if (state is CartAddFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CartAdding) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return PrimayButtonWidget(
                        width: MediaQuery.of(context).size.width * 0.5,
                        buttonText: "Add To Cart",
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        onPress: () {
                          context.read<CartCubit>().addToCart(
                            product.id ?? 0,
                            1,
                          );
                        },
                      );
                    },
                  ),
                  const HeightSpace(8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
