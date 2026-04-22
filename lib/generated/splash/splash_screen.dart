import 'package:e_commerceapp/core/styling/app_assets.dart';
import 'package:e_commerceapp/features/auth/presentation/Views/reg_or_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        AppAssets.splaspath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),

      nextScreen: RegsOrLogScreen(),

      splashIconSize: double.infinity,
    );
  }
}
