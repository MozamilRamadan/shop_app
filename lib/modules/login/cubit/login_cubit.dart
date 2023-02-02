import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/end_points.dart';
import '../../../model/shop_login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit(): super (ShopLoginInitialStates());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late LoginData loginModel;

  void userLogin({
  required String email,
    required String password
}) async {
    emit(ShopLoginLoadingStates());
     DioHelper.postData(
        url: LOGIN,
        data: {
      'email': email,
      'password' : password,
    }).then((value) {
      loginModel = LoginData.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorStates(error.toString()));
      print(error.toString());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;
  void passChange(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopLoginPassChangeStates());
  }
}

