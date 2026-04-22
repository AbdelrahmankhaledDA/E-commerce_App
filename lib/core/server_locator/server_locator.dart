import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/dioService.dart';
import 'package:e_commerceapp/core/styling/theme_cubit.dart';
import 'package:e_commerceapp/features/auth/data/repo/auth_repo_impl.dart';
import 'package:e_commerceapp/features/auth/data/repo/auth_repositry.dart';
import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/login_cubit.dart';
import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/register_cubit.dart';
import 'package:e_commerceapp/features/cart/data/repo/cart_repo.dart';
import 'package:e_commerceapp/features/cart/data/repo/cart_repo_impl.dart';
import 'package:e_commerceapp/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerceapp/features/home/data/repo/categories_repo.dart';
import 'package:e_commerceapp/features/home/data/repo/categories_repo_impl.dart';
import 'package:e_commerceapp/features/home/data/repo/home_repo.dart';
import 'package:e_commerceapp/features/home/data/repo/home_repo_impl.dart';
import 'package:e_commerceapp/features/home/data/repo/product_repo.dart';
import 'package:e_commerceapp/features/home/data/repo/product_repo_impl.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/categories_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/home_cubit.dart';
import 'package:e_commerceapp/features/home/presentation/view_models/product_by_category_cubit.dart';
import 'package:e_commerceapp/features/payment/repo/payment_repo.dart';
import 'package:e_commerceapp/features/payment/repo/stripe_payment.dart';
import 'package:e_commerceapp/features/search/data/repo/search_repo.dart';
import 'package:e_commerceapp/features/search/data/repo/search_repo_impl.dart';
import 'package:e_commerceapp/features/search/presentation/cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupServiceLocator() {
  // dio object
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(DioService(getIt<Dio>()));

  // all repo lazy singleton
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CategoriesRepo>(
    () => CategoriesRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<PaymentRepo>(
    () => StripePayment(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(getIt<ApiService>()),
  );
  // all cubits factory
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepository>()));
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getIt<CategoriesRepo>()),
  );
  getIt.registerFactory<ProductByCategoryCubit>(
    () => ProductByCategoryCubit(getIt<ProductRepo>()),
  );
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepo>()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
}
