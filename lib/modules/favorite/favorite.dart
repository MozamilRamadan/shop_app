import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';
import '../../model/Get_Fav_Model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubits.dart';
import '../../shared/cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  //const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
        // if(state is ShopChangeFavSuccessStates) {
        //   if (!state.model.status!) {
        //     showToast(text: state.model.message!, state: ToastState.ERROR);
        //   }
        // }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: state is! ShopFavGetLoadingStates,
            builder: (context) => ListView.separated(
                itemBuilder:(context, index) => builderFavItems(cubit.favGetModel!.data!.data![index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favGetModel!.data!.data!.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }, );

  }

  Widget builderFavItems(Datum model, context) =>   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage("${model.product!.image}"),
                width: 120.0,
                height: 120.0,
              ),
              if(1 != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),

                  color: Colors.red,
                  child:Text("DISCOUNT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${model.product!.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.0,
                      fontSize: 12),
                ),
                Spacer(),
                Row(children: [
                  Text("${model.product!.price.toString()}",
                    style: TextStyle(color: defaultColor,
                      fontSize: 12,
                    ),),
                  SizedBox(width: 5.0,),
                  if(1 != 0)
                    Text("${model.product!.oldPrice.toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      //print(model.id);
                     ShopCubit.get(context).changeFavorite(model.product!.id!);
                    },
                    icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorite![model.product!.id]! ? defaultColor : Colors.grey  ,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                        )),

                  ),
                  //IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),

                ],),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}