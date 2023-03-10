
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static SharedPreferences? sharedPreferences ;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
static Future<bool> saveData({
    required String? key,
  required dynamic value
})async{
 if(value is bool) return await sharedPreferences!.setBool(key!, value);
 if(value is String) return await sharedPreferences!.setString(key!, value);
 if(value is int) return await sharedPreferences!.setInt(key!, value);
 return await sharedPreferences!.setDouble(key!, value);
}
static Future<bool> removeData({required String key}) async{
    return await sharedPreferences!.remove(key) ;
}
   static Future<bool> setData({
    required String key,
     required bool value,
}) async{
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }


//   static String valueSharedPreferences = '';
//
// // Write DATA
//   static Future<bool> saveUserData(value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return await sharedPreferences.setInt(valueSharedPreferences, value);
//   }
//
// // Read Data
//   static Future getUserData() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getInt(valueSharedPreferences);
//   }

 }