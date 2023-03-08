import 'package:shop_app/models/user_model.dart';

abstract class StatesRegister {}

class ShopeRegisterInitState extends StatesRegister {}

class ShopRegisterSucceessState extends StatesRegister {
  final UserModel model;
  ShopRegisterSucceessState(this.model);
}

class ShopRegisterLoadingState extends StatesRegister {}

class ShopRegisterErrorState extends StatesRegister {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeVisibilityIconState extends StatesRegister {}
