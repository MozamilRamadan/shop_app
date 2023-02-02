import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observe.dart';
import 'package:shop_app/shared/cubit/cubits.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_home_layout.dart';
import 'modules/login/cubit/login_cubit.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/onbording_screen.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/theme_cubit/theme_cubit.dart';
import 'shared/theme_cubit/theme_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

   bool? isDark = CacheHelper.getData(key: 'isDark');
   String? token = CacheHelper.getData(key: 'token');
   bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   Widget widget;

   if(onBoarding != null){
     if(token != null){widget = ShopHomeLayout();}
     else {widget = ShopLoginScreen(); }

   }else {
    widget = OnBoarding_Screen();
  }

  runApp(MyApp(widget,isDark));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
   final bool? isDark;
   final Widget startWidget ;

  MyApp(this.startWidget, this.isDark );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopLoginCubit()),
          BlocProvider(create: (context) =>ShopCubit()..homeGetData()..categoriesGetData()..getFavoritesData()..getUserData(),),
          BlocProvider(create: (context) =>ThemeCubit()..ChangeMode(fromshared: isDark,)),
        ],
        child: BlocConsumer<ThemeCubit, ThemeCubitStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeCubit.get(context).isDark? ThemeMode.light : ThemeMode.light,
              home: startWidget,
            );
          },
          listener: (context, state) {

          },),
    );
  }
}



