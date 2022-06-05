


import 'package:final_pro/modules/login_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/components/default_tff.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  bool ispassword=true;
  bool ispassword2=true;
  bool ismatch=true;
  var usernameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var cpasswordController=TextEditingController();



  var formkey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,

            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                SizedBox(height: 20,),
                Center(
                  child:
                  Image(image:AssetImage('assets/images/logo.png'),
                    height: 150,
                    width: 150,
                  ),
                ),






                Text('Username',
                  style: TextStyle(
                    fontSize: 30,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: defaulttff(
                        context: context,
                        text: '',
                      validatortext: 'username must not be empty',
                        controller: usernameController,
                        onsubmit: (){
                      print(usernameController.text);
                        },
                      onchanged: (){},
                      type: TextInputType.text
                    )),
                const SizedBox(height: 20,),
                Text('Email',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: defaulttff(
                        context: context,
                        text: '',
                      validatortext: 'Email address must not be empty',
                        controller: emailController,
                        onsubmit: (){

                        },
                        onchanged: (){},
                        type: TextInputType.text
                    )),
                const SizedBox(height: 20,),
                Text('Password',
                  style: TextStyle(
                    fontSize: 30,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    context: context,
                    controller: passwordController,
                    onsubmit: (){},
                    onchanged: (){},
                    type: TextInputType.visiblePassword,
                    text: '',
                    validatortext:'password must not be empty',
                    obstext: ispassword,
                    suffixicon:ispassword? IconButton(icon:const Icon(Icons.visibility),
                        onPressed:(){
                          setState(() {
                            ispassword=!ispassword;
                          }
                          );}):IconButton(icon:const Icon(Icons.visibility_off),
                        onPressed:(){
                          setState(() {
                            ispassword=!ispassword;
                          });}),


                  ),
                ),
                const SizedBox(height: 20,),
                Text('Confirm password',
                  style: TextStyle(
                    fontSize: 30,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    context: context,
                    controller: cpasswordController,
                    onsubmit: (){},
                    onchanged: (){},
                    type: TextInputType.visiblePassword,
                    text: '',
                    validatortext:ismatch? '':'password mush match',
                    obstext: ispassword2,
                    suffixicon: ispassword2? IconButton(icon:const Icon(Icons.visibility),
                        onPressed:(){
                          setState(() {
                            ispassword2=!ispassword2;
                          });}):IconButton(icon:const Icon(Icons.visibility_off),onPressed:(){
                      setState(() {
                        ispassword2=!ispassword2;
                      });}),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor('#2e84f5'),
                  ),

                  child: MaterialButton(onPressed: (){

                    setState(() {
                      if(cpasswordController.text==passwordController.text){
                        ismatch=true;
                        print(ismatch);
                      }
                      else if(cpasswordController.text!=passwordController.text) {
                        ismatch=false;
                        print(ismatch);
                      }
                    });


                    if(formkey.currentState!.validate()){


                    }
                  },
                    child: const Text('sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  children: [
                    const Text('already a user?'),

                    Container(
                      width: MediaQuery.of(context).size.width/8,
                      child: TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      },child: const Text('login'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
