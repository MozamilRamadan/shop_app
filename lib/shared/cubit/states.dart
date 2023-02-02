import '../../model/change_fav_model.dart';
import '../../modules/settings/profile_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ChangeNavButtonStates extends ShopStates {}
//==================================================
class ShopLoadingStates extends ShopStates {}
class ShopSuccessStates extends ShopStates {}
class ShopErrorStates extends ShopStates {}
//=============================================
class ShopCategoriesErrorStates extends ShopStates {}
class ShopCategoriesSuccessStates extends ShopStates {}
//=====================================================
class ShopFavGetLoadingStates extends ShopStates {}
class ShopFavGetErrorStates extends ShopStates {}
class ShopFavGetSuccessStates extends ShopStates {}
//=====================================================
class ShopChangeFavErrorStates extends ShopStates {}
class ShopChangeFavSuccessStates extends ShopStates {}
class ShopChangeFavStates extends ShopStates {
  final ChangeFavoriteModel model;
  ShopChangeFavStates(this.model);
}
//=====================================================
class ShopProfileLoadingStates extends ShopStates {}
class ShopProfileErrorStates extends ShopStates {}
class ShopProfileSuccessStates extends ShopStates {
  final ProfileModel profileModel;

  ShopProfileSuccessStates(this.profileModel);
}

//=====================================================
class ShopUpdateLoadingStates extends ShopStates {}
class ShopUpdateErrorStates extends ShopStates {}
class ShopUpdateSuccessStates extends ShopStates {
  final ProfileModel profileModel;
  ShopUpdateSuccessStates(this.profileModel);
}