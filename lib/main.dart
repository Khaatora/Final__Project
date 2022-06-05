

import 'package:final_pro/modules/change_password_screen/change_password.dart';
import 'package:final_pro/modules/login_screen/login.dart';
import 'package:final_pro/modules/password_recovery_screen/password_recovery.dart';
import 'package:final_pro/modules/successlistcubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'modules/sign_up_screen/sign_up.dart';
import 'modules/successlistcubit/cubit.dart';
import 'modules/welcome_screen/welcome.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>SucessListCubit(),
      child:BlocConsumer<SucessListCubit,SuccessListStates>(
        listener:(context,state)=>{} ,
        builder:(context,state){
          return  MaterialApp(


            home:Welcome(),
            theme:ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 17,

                ),
              ),
              primarySwatch: Colors.deepOrange,
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
            darkTheme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              scaffoldBackgroundColor:HexColor('#333739'),

              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor:HexColor('#333739'),
                elevation: 0.0,
              ),

            ),
            themeMode: SucessListCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
            debugShowCheckedModeBanner: false,



          );
        },
      ),


    );
  }
}
