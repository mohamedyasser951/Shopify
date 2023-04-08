import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/searchmodel.dart';

import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CubitSearch extends Cubit<SearchStates> {
  CubitSearch() : super(SearchInitialState());
  static CubitSearch get(context) => BlocProvider.of(context);

 SearchModel? searchModel ;
  
  void getSearch({
    required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: TOKEN,
       data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromjson(value.data);
    //   print("search model full ${value.data}");
      emit(SearchSuccessState());
    }).catchError((error) {
      // print(error);
      emit(SearchErrorState());
    });
  }
}
