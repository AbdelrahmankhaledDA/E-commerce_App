import 'package:e_commerceapp/core/widgets/CustomTextField.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/core/widgets/SpacingWidgets.dart';
import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/login_cubit.dart';
import 'package:e_commerceapp/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/router_generation_config.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Auth_Login.tr()),
        actions: [TranslationIcon(), ThemeButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CustomTextField(
              hintText: "username",
              controller: context.read<LoginCubit>().username,
            ),
            HeightSpace(20.h),
            CustomTextField(
              hintText: "Password",
              controller: context.read<LoginCubit>().password,
              isPassword: true,
            ),
            HeightSpace(20.h),

            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "welcome to E-commerce app ${state.user.username}",
                      ),
                    ),
                  );
                  context.go(RouterGeneration.home);
                }
                if (state is LoginError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return PrimayButtonWidget(
                  buttonText: "Login",
                  onPress: () {
                    context.read<LoginCubit>().login();
                    GoRouter.of(context).push(RouterGeneration.home);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
