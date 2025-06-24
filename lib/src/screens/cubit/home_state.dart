import 'package:news_expo/src/screens/models/saerch_res_model.dart';

class HomeState {
  String searchKeyword;
  DateTime publishAfter;
  SearchResModel? searchResModel;
  bool? loading;
  HomeState({
    required this.publishAfter,
    required this.searchKeyword,
    this.searchResModel,
    this.loading,
  });

  HomeState copyWith({
    String? searchKeyword,
    DateTime? publishAfter,
    SearchResModel? searchResModel,
    bool? loading,
  }) => HomeState(
    searchKeyword: searchKeyword ?? this.searchKeyword,
    publishAfter: publishAfter ?? this.publishAfter,
    searchResModel: searchResModel ?? this.searchResModel,
    loading: loading ?? this.loading,
  );
}
