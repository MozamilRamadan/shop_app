import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token');
  navigatorAndEnd(context, ShopLoginScreen());
}

String? token = "";
