import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  String? Function(String?)? validate,
  VoidCallback? onTap,
  Function? onChange,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) {
  return TextFormField(
    validator: validate,
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onTap: () {
      onTap!();
      print('Taped');
    },
    onChanged: (String s) => onChange!(s),
    decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
        label: Text(label),
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder()),
  );
}

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey,
);

void showToast({
  required String text,
  required state,
})=>
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ChosseColoer(state),
      textColor: Colors.white,
      fontSize: 16.0
  );


 enum ToastState{SUCCESS, WARNING, ERROR}

Color ChosseColoer(ToastState state){
  Color color;
switch(state){
  case ToastState.SUCCESS:
    color = Colors.green;
    break;
  case ToastState.WARNING:
    color = Colors.amber;
    break;
  case ToastState.ERROR:
    color = Colors.red;
}
return color;
}

void navigateTo(context, Widget) => Navigator.push(
    context ,
    MaterialPageRoute(builder: (context) => Widget,) );

void navigatorAndEnd(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>Widget),
        (route) => false);

