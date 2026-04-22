import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/features/home/data/repo/categories_repo.dart';

import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());
  CategoriesRepo categoriesRepo;
  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    final result = await categoriesRepo.getAllCategories();
    result.fold(
      (error) => emit(CategoriesError(error.message)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
