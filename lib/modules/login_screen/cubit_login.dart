// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/login_screen/states.dart';

import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CubitLogin extends Cubit<StatesLogin> {
  CubitLogin() : super(ShopeLoginInitState());

  static CubitLogin get(context) => BlocProvider.of(context);

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;

  late UserModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = UserModel.fromjson(value.data);
      

      emit(ShopLoginSucceessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changeVisiblity() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityIconState());
  }
}
