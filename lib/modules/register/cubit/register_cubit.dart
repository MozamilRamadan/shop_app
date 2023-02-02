
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/register_state.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../model/shop_login_model.dart';
import '../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit(): super (ShopRegisterInitialStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginData? loginModel;

  void userRegister({
  required String email,
  required String phone,
  required String name,
    required String password
}) async {
    emit(ShopRegisterLoadingStates());
     DioHelper.postData(
        url: REGISTER,
        data: {
      'email': email,
      'name': name,
      'phone': phone,
      'password' : password,
    }).then((value) {
      loginModel = LoginData.fromJson(value.data);
      emit(ShopRegisterSuccessStates(loginModel));
    }).catchError((error){
      emit(ShopRegisterErrorStates(error.toString()));
      print(error.toString());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;
  void passChange(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopRegisterPassChangeStates());
  }
}

