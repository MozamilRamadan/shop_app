import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/shop_category_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubits.dart';
import '../../shared/cubit/states.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder:(context, state) {
          var cubit = ShopCubit.get(context);
          return ListView.separated(
              itemBuilder: (context, index) => categoriesBuilder(cubit.categoriesModel!.data!.data[index]),
              separatorBuilder:(context, index) =>  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: myDivider(),
              ),
              itemCount: cubit.categoriesModel!.data!.data.length);
        },
    );



  }
  Widget categoriesBuilder(ModelData model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        const SizedBox(width: 20,),
        Text('${model.name}'),
        Spacer(),
        const Icon(Icons.arrow_forward_ios_sharp),
      ],
    ),
  );
}
