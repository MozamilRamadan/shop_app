import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

import '../shared/cubit/cubits.dart';
import '../shared/cubit/states.dart';
class ShopHomeLayout extends StatelessWidget {
  //const ShopHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

         // var cubit = ShopCubit.get(context);
          return BlocConsumer<ShopCubit,ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ShopCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Sella"),
                  actions: [
                    IconButton(onPressed: (){
                      navigateTo(context, SearchScreen());
                    }, icon: const Icon(Icons.search_rounded))
                  ],
                ),
                body: cubit.screen[cubit.currentIndex],
                //=========================================
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    cubit.changeNav(index);
                  },
                    items: const [
                      BottomNavigationBarItem(icon:Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(icon:Icon(Icons.apps),
                        label: 'Category',
                      ),

                      BottomNavigationBarItem(icon:Icon(Icons.favorite_border_rounded),
                        label: 'Favorite',
                      ),
                      BottomNavigationBarItem(icon:Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ]),
              );
            },

          );

  }
}
