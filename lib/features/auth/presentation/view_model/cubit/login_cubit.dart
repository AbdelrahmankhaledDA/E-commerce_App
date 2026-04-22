import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/core/storage/cach_helper.dart';
import 'package:e_commerceapp/features/auth/data/model/UserModels.dart';

import 'package:e_commerceapp/features/auth/data/repo/auth_repositry.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository _auth;
  LoginCubit(this._auth) : super(LoginInitial());
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    emit(LoginLoading());
    try {
      final result = await _auth.loginUserbyApi(username.text, password.text);
      result.fold((failures) => emit(LoginError(failures.message)), (
        user,
      ) async {
        if (user.token != null) {
          await CachHelper.saveData('token', user.token);
          print("Token received: ${user.token}");
        }

        emit(LoginSuccess(user));
      });
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    username.dispose();
    password.dispose();
    return super.close();
  }
}
