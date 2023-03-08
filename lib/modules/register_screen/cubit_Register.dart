import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/register_screen/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CubitRegister extends Cubit<StatesRegister> {
  CubitRegister() : super(ShopeRegisterInitState());

  static CubitRegister get(context) => BlocProvider.of(context);

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;

  late UserModel RegisterModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "email": email,
      "password": password,
      "name":name,
      "phone":phone,
    }).then((value) {
      RegisterModel = UserModel.fromjson(value.data);
      

      emit(ShopRegisterSucceessState(RegisterModel));
    }).catchError((error) {
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changeVisiblity() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityIconState());
  }
}
