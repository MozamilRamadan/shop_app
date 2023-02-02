import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/shop_home_layout.dart';
import '../../shared/components/components.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class ShopRegisterScreen extends StatelessWidget {
    ShopRegisterScreen({Key? key}) : super(key: key);
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShopRegisterCubit(),
    child:BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      listener: (context, state) {
        if(state is ShopRegisterSuccessStates){
          if(state.loginModel!.status!){
            CacheHelper.saveData(key: "token", value: state.loginModel!.data!.token!
            ).then((value) {
            });
            showToast(
                text: state.loginModel!.message!,
                state:ToastState.SUCCESS );
            navigatorAndEnd(context, ShopHomeLayout());

          }else{
            showToast(
                text:state.loginModel!.message!,
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Regiter Now To Have Enjoy',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextFormField(
                          controller: nameController,
                          onFieldSubmitted: (value) {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);}
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return('Name Must Not Be Empty');
                            }
                            return null;
                          },
                          onChanged: (value){
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                            prefixIcon: const  Icon(Icons.person_add),

                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: 20,),
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
                      const SizedBox(height: 20,),
                      TextFormField(
                          controller: phoneController,
                          onFieldSubmitted: (value) {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);}
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return('Phone Must Not Be Empty');
                            }
                            return null;
                          },
                          onChanged: (value){
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(

                            prefixIcon: const  Icon(Icons.local_phone_sharp),

                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                          controller: passwordController,
                          onFieldSubmitted: (value) {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,

                                  password: passwordController.text);}
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return('Password Must Not Be Empty');
                            }
                            return null;
                          },
                          onChanged: (value){
                          },
                          keyboardType: TextInputType.text,
                          obscureText: cubit.isPassword,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed:(){cubit.passChange();},
                              icon:Icon(cubit.suffix), ),
                            prefixIcon: const Icon(Icons.lock_clock_rounded),

                            labelText: 'Enter Password',
                            border: OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: 30,),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingStates ,
                        builder:(context) =>
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              child:
                              MaterialButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: const Text('Register',
                                  style: TextStyle(
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                        fallback: (context) => Center(child: const CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ),
        );
      },
    ) ,
    );


  }
}

