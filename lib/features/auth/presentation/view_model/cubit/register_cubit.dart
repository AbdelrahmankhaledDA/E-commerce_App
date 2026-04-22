import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/features/auth/data/model/UserModels.dart';
import 'package:e_commerceapp/features/auth/data/repo/auth_repositry.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._auth) : super(RegisterInitial());
  AuthRepository _auth;
  register(String username, String email, String password) async {
    emit(RegisterLoading());

    try {
      final result = await _auth.registerByApi(username, email, password);
      result.fold(
        (failure) => emit(RegisterError(failure.message)),
        (user) => emit(RegisterSuccess(user)),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
