import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

void navigateAndReplecement(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
  Function? function,
  String?Function(String?)? validate,
  IconData? suffixIcon,
  var suffixPressed,
}) {
  //final String?Function(String?)? validatorFun;
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
    ),
    obscureText: isPassword,
    validator: validate,
  );
}

Widget defaultButton(var function, String text, context) {
  return InkWell(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(
              Radius.circular(10))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Center(
          child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )),
    ),
  );
}
