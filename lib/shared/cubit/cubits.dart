import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../model/Get_Fav_Model.dart';
import '../../model/change_fav_model.dart';
import '../../model/shop_category_model.dart';
import '../../model/shop_user_model.dart';
import '../../modules/category/category.dart';
import '../../modules/favorite/favorite.dart';
import '../../modules/products/products.dart';
import '../../modules/settings/profile_model.dart';
import '../../modules/settings/settings.dart';
import '../components/constants.dart';
import '../network/end_points.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  int currentIndex = 0;

  void changeNav(int index) {
    currentIndex = index;
    emit(ChangeNavButtonStates());
  }

  //=======================================================
  HomeModel? homeModel;
  Map<int, bool>? favorite = {};

  void homeGetData() {
    emit(ShopLoadingStates());
    DioHelper.getData(url: HOME, token: CacheHelper.getData(key: 'token')!).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorite!.addAll({
          element.id: element.inFavorite
        });
      }
     // print("From HomeGet ${favorite.toString()}");
      emit(ShopSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorStates());
    });
  }

//=====================================================
  CategoriesModel? categoriesModel;

  void categoriesGetData() {
    DioHelper.getData(url: GET_CATEGORIES, token: CacheHelper.getData(key: 'token')).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorStates());
    });
  }

  //=====================================================
  ChangeFavoriteModel? changeFav;

  void changeFavorite(int productId) {
    favorite![productId] = !favorite![productId]!;
    emit(ShopChangeFavSuccessStates());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": productId,
      },
      token: CacheHelper.getData(key: 'token'),

    ).then((value) {
      changeFav = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFav!.status!) {
        favorite![productId] = !favorite![productId]!;
      }else{getFavoritesData();}

      emit(ShopChangeFavSuccessStates());
    }).catchError((error) {
      favorite![productId] = !favorite![productId]!;
      emit(ShopChangeFavErrorStates());
    });
  }


//=====================================================
   Welcome? favGetModel;

  void getFavoritesData() {
    emit(ShopFavGetLoadingStates());
    DioHelper.getData(url: FAVORITES, token: CacheHelper.getData(key: 'token')).then((value) {
      favGetModel = Welcome.fromJson(value.data);
      print(favGetModel!.message);
      emit(ShopFavGetSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavGetErrorStates());
    });
  }

//====================================================

  ProfileModel? profileModel;

void getUserData() {
  emit(ShopProfileLoadingStates());
  DioHelper.getData(url: PROFILE, token: token).then((value) {
    profileModel = ProfileModel.fromJson(value.data);
    emit(ShopProfileSuccessStates(
        profileModel!
    ));
  }).catchError((error) {
    print(error.toString());
    emit(ShopProfileErrorStates());
  });
}
//====================================================

  void userUpdateData({
      required String name,
      required String email,
      required String phone,
}) {
    emit(ShopUpdateLoadingStates());
    DioHelper.updateData(
        url: UPDATE_PROFILE,
        token: CacheHelper.getData(key: 'token'),
        data: {
      'name':name,
      'email': email,
      'phone':phone
    }, ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ShopUpdateSuccessStates(
          profileModel!
      ));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateErrorStates());
    });
  }
}
//====================================================

