import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/regester_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class ShopLoginScreen extends StatelessWidget {
 // const ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLoginCubit,ShopLoginStates>(
            listener: (context, state) {
              if(state is ShopLoginSuccessStates){
                  if(state.loginModel.status!){
                  CacheHelper.saveData(key: "token", value: state.loginModel.data!.token!
                  ).then((value) {
                  });
                  showToast(
                      text: state.loginModel.message!,
                      state:ToastState.SUCCESS );
                  navigatorAndEnd(context, ShopHomeLayout());

                }else{
                  showToast(
                      text:state.loginModel.message!,
                      state: ToastState.ERROR);
                }
              }
            },
            builder: (context, state) {
             var cubit = ShopLoginCubit.get(context);
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
                                      Text('Login',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Text('Login To Have Enjoy',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 30.0,),
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
                                          controller: passwordController,
                                          onFieldSubmitted: (value) {
                                            if(formKey.currentState!.validate()){
                                            ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
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
                                        condition: state is! ShopLoginLoadingStates ,
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
                                                ShopLoginCubit.get(context).userLogin(
                                                    email: emailController.text,
                                                    password: passwordController.text);
                                              }
                                            },
                                            child: const Text('LOGIN',
                                              style: TextStyle(
                                                color: Colors.white,

                                              ),
                                            ),
                                          ),
                                        ),
                                        fallback: (context) => Center(child: const CircularProgressIndicator()),


                                      ),
                                      Row(
                                        children: [
                                          const Text('Don\'t Have an Account?'),
                                          TextButton(
                                            onPressed: (){
                                              navigateTo(context, ShopRegisterScreen());
                                            },
                                            child: const Text('Register Now'),

                                          )
                                        ],
                                      )
                                    ],
                                  ),
                      ),
                    ),
                  ),

                ),
              );
            },
    );
  }
}
