import 'package:bloc/bloc.dart';
import 'package:news_expo/src/screens/cubit/home_state.dart';
import 'package:news_expo/src/screens/functions/home_functions.dart';
import 'package:news_expo/src/screens/models/saerch_res_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
    : super(
        HomeState(searchKeyword: "Apple", publishAfter: DateTime(2025, 05, 24)),
      );

  void changeSearchRes(SearchResModel? searchResModel) {
    if (searchResModel != null) {
      emit(state.copyWith(searchResModel: searchResModel));
    }
  }

  void getNewsData(String keyword) async {
    emit(state.copyWith(loading: true, searchKeyword: keyword));
    String url = HomeFunctions.getSearchURL(keyword, state.publishAfter);
    SearchResModel? res = await HomeFunctions.searchOverArticle(url);
    emit(state.copyWith(loading: false));
    changeSearchRes(res);
  }
}
