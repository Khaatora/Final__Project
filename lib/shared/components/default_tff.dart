

import 'package:flutter/material.dart';


  Widget defaulttff({
  required String text,
  IconButton? suffixicon,
  bool obstext=false,
  String  validatortext='',
  required TextEditingController controller,
  required TextInputType type,
  required Function onsubmit,
  required Function onchanged,
  required BuildContext context,
})=> TextFormField(

style:Theme.of(context).textTheme.bodyText1,

controller:controller,
keyboardType:type,
onFieldSubmitted: onsubmit(),
onChanged: onchanged(),


validator: (value){
  if(value!.isEmpty){
    return validatortext;
  }
  return null;
},
textDirection: TextDirection.ltr,
obscureText: obstext,
    decoration: InputDecoration(
      contentPadding:EdgeInsets.symmetric(horizontal: 10,vertical: 0) ,
    hintText: text,
    suffixIcon:suffixicon,
    border:
<<<<<<< HEAD

    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),
=======
    OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
>>>>>>> ac56efad6652e3ed3930a74a13c519771d60aed5

    ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[800]),
  ),

);