

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

})=> TextFormField(


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
    hintText: text,
    suffixIcon:suffixicon,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
    ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[800]),
  ),




);