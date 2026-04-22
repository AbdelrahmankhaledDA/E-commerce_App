import 'package:e_commerceapp/features/auth/presentation/Views/LoginScreen.dart';
import 'package:e_commerceapp/features/auth/presentation/Views/reg_or_log_screen.dart';
import 'package:e_commerceapp/features/auth/presentation/Views/register_screen.dart';
import 'package:e_commerceapp/features/cart/presentation/views/screens/cart_screen.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:e_commerceapp/features/home/presentation/views/screens/home_screen.dart';
import 'package:e_commerceapp/features/home/presentation/views/screens/product_screen.dart';
import 'package:e_commerceapp/features/maps/presentation/MapScreen.dart';
import 'package:e_commerceapp/features/search/presentation/screens/search_screen.dart';
import 'package:e_commerceapp/generated/splash/splash_screen.dart';
import 'package:e_commerceapp/main.dart';
import 'package:go_router/go_router.dart';

class RouterGeneration {
  static String splash = "/splash";
  static String home = "/home";
  static String map = "/map";
  static String searchScreen = "/SearchScreen";
  static String login = "/login";
  static String register = "/register";
  static String details = "/details";
  static String cartscreen = "/cartScreen";
  static String regorlog = "/regorlog";
  static GoRouter goRouter = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return RegisterScreen();
        },
      ),
      GoRoute(
        path: regorlog,
        builder: (context, state) {
          return RegsOrLogScreen();
        },
      ),
      GoRoute(
        path: home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: searchScreen,
        builder: (context, state) {
          return SearchScreen();
        },
      ),
      GoRoute(
        path: map,
        builder: (context, state) {
          return MapScreen();
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) {
          return Loginscreen();
        },
      ),
      GoRoute(
        path: cartscreen,
        builder: (context, state) {
          return CartScreen();
        },
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          ProductModel product = state.extra as ProductModel;
          return ProductScreen(product: product);
        },
      ),
    ],
  );
}
