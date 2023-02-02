import '../../../model/shop_login_model.dart';

abstract class ShopRegisterStates {
  get loginModel => null;
}
class ShopRegisterPassChangeStates extends ShopRegisterStates {}
class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}
class ShopRegisterSuccessStates extends ShopRegisterStates {
   LoginData? loginModel;
  ShopRegisterSuccessStates(this.loginModel);
}
class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorStates(this.error);
}
//=================================================================================


