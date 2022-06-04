

import 'package:final_pro/modules/change_password_screen/change_password.dart';
import 'package:final_pro/modules/login_screen/login.dart';
import 'package:final_pro/modules/password_recovery_screen/password_recovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'modules/sign_up_screen/sign_up.dart';
import 'modules/welcome_screen/welcome.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home:ChangePassword(),
      theme:ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
           backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor:Colors.white,
          elevation: 0.0,
        ),
      ),


      debugShowCheckedModeBanner: false,



    );
  }
}
