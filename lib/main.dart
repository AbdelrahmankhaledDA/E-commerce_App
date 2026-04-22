import 'dart:async';

import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/server_locator/server_locator.dart';
import 'package:e_commerceapp/core/storage/cach_helper.dart';
import 'package:e_commerceapp/core/styling/theme_cubit.dart';
import 'package:e_commerceapp/core/styling/theme_data.dart';

import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/login_cubit.dart';
import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/register_cubit.dart';
import 'package:e_commerceapp/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/categories_cubit.dart'
    show CategoriesCubit;
import 'package:e_commerceapp/features/home/presentation/view_models/home_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/product_by_category_cubit.dart';
import 'package:e_commerceapp/features/search/presentation/cubit/search_cubit.dart';
import 'package:e_commerceapp/generated/codegen_loader.g.dart';
import 'package:e_commerceapp/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  Stripe.publishableKey = "";
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CachHelper.initial();
  setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: "assets/translations",
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LoginCubit>()),
          BlocProvider(create: (context) => getIt<RegisterCubit>()),

          BlocProvider(create: (context) => getIt<HomeCubit>()),
          BlocProvider(create: (context) => ThemeCubit()),

          BlocProvider(create: (context) => getIt<CategoriesCubit>()),
          BlocProvider(create: (context) => getIt<ProductByCategoryCubit>()),
          BlocProvider(create: (context) => getIt<CartCubit>()),
          BlocProvider(create: (context) => getIt<SearchCubit>()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              title: 'Flutter Demo',
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: state,
              routerConfig: RouterGeneration.goRouter,
            );
          },
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               if (context.locale.languageCode == 'en') {
//                 context.setLocale(Locale('ar'));
//               } else {
//                 context.setLocale(Locale('en'));
//               }
//             },
//             icon: Icon(Icons.language),
//           ),
//           IconButton(
//             onPressed: () {
//               context.go(RouterGeneration.splash);
//             },
//             icon: Icon(Icons.arrow_back),
//           ),
//         ],
//       ),
//       body: Center(child: Text(LocaleKeys.Auth_email.tr())),
//     );
//   }
// }

// class MapSample extends StatefulWidget {
//   const MapSample({super.key});

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//     bearing: 192.8334901395799,
//     target: LatLng(37.43296265331129, -122.08832357078792),
//     tilt: 59.440717697143555,
//     zoom: 19.151926040649414,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

// class Sec extends StatelessWidget {
//   const Sec({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
