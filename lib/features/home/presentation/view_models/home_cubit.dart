import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/features/home/data/models/response_products_model.dart';

import 'package:e_commerceapp/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homerepo) : super(HomeInitial()) {
    getAllProducts();
  }
  HomeRepo homerepo;

  getAllProducts() async {
    emit(HomeLoading());
    final result = await homerepo.getAllProducts();
    result.fold(
      (error) => emit(HomeError(error.message)),
      (loaded) => emit(HomeSuccess(loaded)),
    );
  }
}
