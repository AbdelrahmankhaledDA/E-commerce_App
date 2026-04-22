import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/styling/AppColors.dart';
import 'package:e_commerceapp/core/styling/app_styles.dart';
import 'package:e_commerceapp/core/widgets/CustomTextField.dart';
import 'package:e_commerceapp/core/widgets/SpacingWidgets.dart';
import 'package:e_commerceapp/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/home_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/views/widgets/ListProductBlocBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getAllProducts();
    super.initState();
  }

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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(28),
            SizedBox(
              width: 335.w,
              child: Text("Discover", style: AppStyles.primaryHeadLinesStyle),
            ),
            const HeightSpace(16),
            InkWell(
              onTap: () {
                context.push(RouterGeneration.searchScreen);
              },
              child: Row(
                children: [
                  AbsorbPointer(
                    child: CustomTextField(
                      width: 270.w,
                      hintText: "Search For Anything",
                    ),
                  ),
                  const WidthSpace(8),
                  Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.push(RouterGeneration.searchScreen);
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const HeightSpace(16),

            /// categories
            Listproductblocbuilder(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
