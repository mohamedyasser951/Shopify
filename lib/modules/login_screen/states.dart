import 'package:shop_app/models/user_model.dart';

abstract class StatesLogin {}

class ShopeLoginInitState extends StatesLogin {}

class ShopLoginSucceessState extends StatesLogin {
  final UserModel loginModel;
  ShopLoginSucceessState(this.loginModel);
}

class ShopLoginLoadingState extends StatesLogin {}

class ShopLoginErrorState extends StatesLogin {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangeVisibilityIconState extends StatesLogin {}
