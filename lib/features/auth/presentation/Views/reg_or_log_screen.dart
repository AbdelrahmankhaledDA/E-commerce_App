import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/styling/AppColors.dart';
import 'package:e_commerceapp/core/styling/app_assets.dart';
import 'package:e_commerceapp/core/styling/app_styles.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/core/widgets/SpacingWidgets.dart';
import 'package:e_commerceapp/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegsOrLogScreen extends StatelessWidget {
  const RegsOrLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Current Locale: ${context.locale}");
    print("Translated Login: ${LocaleKeys.Auth_Login.tr()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.Auth_Lets_create_your_account.tr(),
          style: TextStyle(fontSize: 18),
        ),
        actions: [TranslationIcon(), ThemeButton()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(AppAssets.logoPath)),
              HeightSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.Auth_Welcome_to.tr(),
                    style: AppStyles.black18BoldStyle,
                  ),
                  const SizedBox(width: 5),
                  Text('E-commenrce APP', style: AppStyles.black18BoldStyle),
                ],
              ),
              HeightSpace(60),
              PrimayButtonWidget(
                buttonText: LocaleKeys.Auth_Login.tr(),
                textColor: AppColors.blackColor,
                buttonColor: AppColors.primaryColor,
                bordersRadius: 8,
                height: 50.h,
                width: 371.w,
                onPress: () {
                  GoRouter.of(context).push(RouterGeneration.login);
                },
              ),
              HeightSpace(30),
              PrimayButtonWidget(
                buttonText: LocaleKeys.Auth_Register.tr(),
                buttonColor: AppColors.primaryColor,
                bordersRadius: 8,
                height: 50.h,
                width: 371.w,
                textColor: AppColors.blackColor,
                onPress: () {
                  GoRouter.of(context).push(RouterGeneration.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
