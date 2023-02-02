import '../../../model/shop_login_model.dart';

abstract class ShopLoginStates {
  get loginModel => null;
}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  late  LoginData loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopLoginPassChangeStates extends ShopLoginStates {}
