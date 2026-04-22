import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/styling/AppColors.dart';
import 'package:e_commerceapp/core/styling/app_styles.dart';
import 'package:e_commerceapp/core/widgets/CustomTextField.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/core/widgets/SpacingWidgets.dart';
import 'package:e_commerceapp/features/auth/presentation/view_model/cubit/register_cubit.dart';
import 'package:e_commerceapp/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Auth_Register.tr()),
        actions: [TranslationIcon(), ThemeButton()],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    hintText: LocaleKeys.Auth_email.tr(),
                  ),
                  HeightSpace(30),

                  CustomTextField(
                    controller: userNameController,
                    hintText: LocaleKeys.Auth_username.tr(),
                  ),
                  HeightSpace(30),
                  CustomTextField(
                    controller: passwordController,
                    hintText: LocaleKeys.Auth_password.tr(),
                    isPassword: true,
                  ),
                  HeightSpace(30),

                  HeightSpace(50),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        context.go(RouterGeneration.map);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Welcome ${state.user.username}'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      if (state is RegisterError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return PrimayButtonWidget(
                        buttonText: LocaleKeys.Auth_Register.tr(),
                        textColor: AppColors.blackColor,
                        buttonColor: AppColors.primaryColor,
                        bordersRadius: 8,
                        onPress: () {
                          context.read<RegisterCubit>().register(
                            userNameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                      );
                    },
                  ),
                  HeightSpace(90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.Auth_Already_have_an_account.tr(),
                        style: AppStyles.grey12MediumStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(RouterGeneration.login);
                        },
                        child: Text(
                          LocaleKeys.Auth_Login.tr(),
                          style: AppStyles.black15BoldStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
