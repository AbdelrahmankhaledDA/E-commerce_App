import 'package:e_commerceapp/core/styling/AppColors.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/home_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/views/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Listproductblocbuilder extends StatelessWidget {
  const Listproductblocbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeSuccess) {
          final productsList = state.products.product;

          if (productsList.isEmpty) {
            return const Expanded(
              child: Center(child: Text("No products found")),
            );
          }

          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().getAllProducts();
              },
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.sp,
                  crossAxisSpacing: 16.sp,
                  childAspectRatio: 0.40,
                ),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  return ProductWidget(product: productsList[index]);
                },
              ),
            ),
          );
        }

        if (state is HomeError) {
          return Expanded(child: Center(child: Text(state.error)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
