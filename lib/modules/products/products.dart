import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/shop_category_model.dart';
import '../../model/shop_user_model.dart';
import '../../shared/cubit/cubits.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
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
              condition: cubit.homeModel !=null && cubit.categoriesModel != null,
              builder: (context) => builderWidget(cubit.homeModel!, cubit.categoriesModel!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        }, );
  }

  Widget builderWidget(HomeModel model, CategoriesModel cate, context) => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
                image: NetworkImage('${e.image}'),
              fit: BoxFit.cover,
              width: double.infinity,
            )).toList(),
            options: CarouselOptions(
                height: 220.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
            )),
        const SizedBox(height:10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height:20.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => categoriesListBuilder(cate.data!.data[index]),
                    separatorBuilder: (context, index) =>  const SizedBox(width:6.0),
                    itemCount: cate.data!.data.length),
              ),
            ),
            const SizedBox(height:30.0),

            const Text("News Products",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          child: GridView.count(
            crossAxisCount: 2,
           mainAxisSpacing: 1.0,
           crossAxisSpacing: 1.0,
           childAspectRatio: 1/1.63,
           physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(model.data!.products.length, (index) => buildProducts(model.data!.products[index], context),
              ),
          ),
        ),
      ],
    ),
  );

  Widget categoriesListBuilder(ModelData model)=>Stack(

    alignment: AlignmentDirectional.bottomStart,

    children: [
      Image(image: NetworkImage('${model.image}'),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(

        color: Colors.black.withOpacity(0.5),
        width: 100,
        child: Text("${model.name}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white

          ),
        ),

      ),
    ],


  ) ;

  Widget buildProducts(ProductModel model , context) =>
      Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage("${model.image}"),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount !=0)
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
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${model.name}",
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.0,
                fontSize: 12),
              ),
              Row(children: [
                Text("${model.price!.round()}",
                style: TextStyle(color: defaultColor,
                fontSize: 12,
                ),),
                SizedBox(width: 5.0,),
                if(model.discount != 0)
                Text("${model.oldPrice!.round()}",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
                ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    print(model.id);
                    ShopCubit.get(context).changeFavorite(model.id);
                  },
                  icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorite![model.id]! ? defaultColor : Colors.grey  ,
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
  );
}
