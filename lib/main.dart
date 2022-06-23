// ignore_for_file: prefer_const_constructors

import 'package:final_pro/modules/successlistcubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'modules/successlistcubit/cubit.dart';
import 'modules/welcome_screen/welcome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  final _initializaiton = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializaiton,
      builder: (context, snapshot) {

        if (snapshot.connectionState != ConnectionState.done){
          return Center(child : CircularProgressIndicator());
        }

        return BlocProvider(
          create: (context) => SucessListCubit(),
          child: BlocConsumer<SucessListCubit, SuccessListStates>(
            listener: (context, state) => {},
            builder: (context, state) {
              return GetMaterialApp(
                home: Welcome(),
                theme: ThemeData(
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
                    backgroundColor: Colors.white,
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
                  scaffoldBackgroundColor: HexColor('#333739'),
                  primarySwatch: Colors.deepOrange,
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('#333739'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: HexColor('#333739'),
                    elevation: 0.0,
                  ),
                ),
                themeMode: SucessListCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      }
    );
  }
}
