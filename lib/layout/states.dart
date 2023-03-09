import 'package:shop_app/models/changefavoritesmodel.dart';
import 'package:shop_app/models/user_model.dart';

class HomeLayoutStates {}

class HomeLayoutInitiState extends HomeLayoutStates {}

class HomeLayoutBottomNavBarState extends HomeLayoutStates {}

class HomeDataLoadingState extends HomeLayoutStates {}

class HomeDataSuccessState extends HomeLayoutStates {}

class HomeDataErrorState extends HomeLayoutStates {}

class CategoriesDataSuccessState extends HomeLayoutStates {}

class CategoriesDataErrorState extends HomeLayoutStates {}

class FavoritesChangeState extends HomeLayoutStates {}

class FavoritesDataSuccessState extends HomeLayoutStates {
  final ChanegFavoritesModel model;

  FavoritesDataSuccessState(this.model);
}

class FavoritesDataErrorState extends HomeLayoutStates {}

class GetFavoritesLoadingState extends HomeLayoutStates {}

class GetFavoritesDataSuccessState extends HomeLayoutStates {}

class GetFavoritesErrorState extends HomeLayoutStates {}

class GetProfileLoadingState extends HomeLayoutStates {}

class GetProfileSuccessState extends HomeLayoutStates {}

class GetProfileErrorState extends HomeLayoutStates {}

class UpdateProfileLoadingState extends HomeLayoutStates {}

class UpdateProfileSuccessState extends HomeLayoutStates {
  final UserModel model;

  UpdateProfileSuccessState(this.model);
}

class UpdateProfileErrorState extends HomeLayoutStates {}

class AppChangeModeState extends HomeLayoutStates{}