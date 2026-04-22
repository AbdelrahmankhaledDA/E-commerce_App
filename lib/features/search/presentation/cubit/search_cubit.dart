import 'package:bloc/bloc.dart';
import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:e_commerceapp/features/search/data/repo/search_repo.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial()) {
    queryStream.debounceTime(Duration(milliseconds: 500)).listen(_callApi);
  }
  SearchRepo searchRepo;
  final queryStream = BehaviorSubject<String>();

  searchProducts(String q) {
    queryStream.add(q);
  }

  _callApi(String query) async {
    emit(SearchLoading());
    final result = await searchRepo.searchProduct(query);
    result.fold(
      (failure) => emit(SearchFailure(failure.message)),
      (products) => emit(SearchSuccess(products.product)),
    );
  }
}
