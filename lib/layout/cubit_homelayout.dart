import 'package:flutter/cupertino.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changefavoritesmodel.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class CubitHomeLayout extends Cubit<HomeLayoutStates> {
  CubitHomeLayout() : super(HomeLayoutInitiState());

  static CubitHomeLayout get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
   const ProductsScreen(),
    CategoriesScreen(),
    FavorietsScreen(),
   const settingsScreen(),
  ];

  bool isDark = false;

  void changeMode({bool? modeFromShared}) {
    if (modeFromShared != null) {
      isDark = modeFromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      SharedHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeNavBarState(val) {
    currentIndex = val;
    emit(HomeLayoutBottomNavBarState());
  }

  HomeModel? homeModel;
  late Map<int, bool> favoriets = {};

  void getHomeData() async {
    emit(HomeDataLoadingState());

    DioHelper.getData(url: HOME).then((value) {
      homeModel = HomeModel.fromjson(value.data);

      homeModel!.data!.products.forEach((element) {
        favoriets.addAll({element.id: element.inFavorites});
        // print("hi broo ${favoriets.toString()}");
      });

      emit(HomeDataSuccessState());
    }).catchError((e) {
      
      emit(HomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromjson(value.data);
      //print(categoryModel?.data.toString());
      emit(CategoriesDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(CategoriesDataErrorState());
    });
  }

  ChanegFavoritesModel? chanegFavoritesModel;
  void changeFavorItes(int productId) {
    favoriets[productId] = !favoriets[productId]!;
    emit(FavoritesChangeState());
    DioHelper.postData(
      url: GET_FAVORITES,
      data: {"product_id": productId},
      token: TOKEN,
    ).then((value) {
      chanegFavoritesModel = ChanegFavoritesModel.fromjson(value.data);
      if (!chanegFavoritesModel!.status!) {
        favoriets[productId] = !favoriets[productId]!;
      } else {
        GetFvorites();
      }
      emit(FavoritesDataSuccessState(chanegFavoritesModel!));
    }).catchError((e) {
      favoriets[productId] = !favoriets[productId]!;
      emit(FavoritesDataErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void GetFvorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: GET_FAVORITES, token: TOKEN).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(value.data.toString());
      emit(GetFavoritesDataSuccessState());
    }).catchError((e) {
      emit(GetFavoritesErrorState());
    });
  }

  UserModel? userModel;
  void GetProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: GET_PROFILE, token: TOKEN).then((value) {
      userModel = UserModel.fromjson(value.data);
      // print(value.data.toString());
      emit(GetProfileSuccessState());
    }).catchError((e) {
      emit(GetProfileErrorState());
    });
  }

  void updateProfile(
      {required String name, required String email, required String phone}) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: TOKEN, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      userModel = UserModel.fromjson(value.data);
      //  print(value.data.toString());
      emit(UpdateProfileSuccessState(userModel!));
    }).catchError((e) {
      emit(UpdateProfileErrorState());
    });
  }
}
