import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubits.dart';
import '../../shared/cubit/states.dart';
import '../login/shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  //var formKey = FormField<FormState>;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if(state is ShopProfileSuccessStates){
        //   nameController.text = state.profileModel.data!.name!;
        //   emailController.text = state.profileModel.data!.email!;
        //   phoneController.text = state.profileModel.data!.phone!;
        // }
      },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          nameController.text = cubit.profileModel!.data!.name!;
          emailController.text = cubit.profileModel!.data!.email!;
          phoneController.text = cubit.profileModel!.data!.phone!;
        return ConditionalBuilder(
            condition: cubit.profileModel != null,
            builder: (context) => builderItem(context) ,
            fallback: (context) => Center(child: CircularProgressIndicator()),
             );
        },
        );
  }
  Widget builderItem(context) =>
      Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  onChanged: (value){
                  },
                  validator: (vlaue){
                    if(vlaue!.isEmpty){
                      return('Name Must Not be Empty');
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                //=============================================
                TextFormField(
                  controller: emailController,
                  onChanged: (value){
                  },
                  validator: (vlaue){
                    if(vlaue!.isEmpty){
                      return('Email Must Not be Empty');
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                //==============================================
                TextFormField(
                  controller: phoneController,
                  onChanged: (value){
                  },
                  validator: (vlaue){
                    if(vlaue!.isEmpty){
                      return('Phone Must Not be Empty');
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_in_talk_rounded),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,

                  ),
                  child: MaterialButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                      ShopCubit.get(context).userUpdateData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text);}

                      //   Navigator.of(context).pushAndRemoveUntil(
                      //       MaterialPageRoute(
                      //         builder: (context) => ShopLoginScreen(),), (route) => false);
                      //
                    },
                    child: Text("UPDATE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20.0),
                 height: 40,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.blue,

                 ),
                 child: MaterialButton(
                   onPressed: (){
                     Navigator.of(context).pushAndRemoveUntil(
                         MaterialPageRoute(
                           builder: (context) => ShopLoginScreen(),), (route) => false);
                   },
                 child: Text("LOGOUT",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: Colors.white
                 ),
                 ),
                 ),
               ),



              ],
            ),
          ),
        ),
      ) ;
}
