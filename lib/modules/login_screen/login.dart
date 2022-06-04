
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/components/default_tff.dart';





class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formkey=new GlobalKey<FormState>();
  bool ispassword=true;
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  void initState() {
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
                SizedBox(height: 30,),
                Container(
                  child: Center(
                    child: const Image(image:AssetImage('assets/images/logo.png'),
                        height: 150,
                        width: 150,
                      ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('Email',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    controller: emailController,
                    onsubmit: (){},
                    onchanged: (){},
                    type: TextInputType.text,
                    text: '',
                    validatortext: 'email address must not be empty',

                  ),
                ),
                const SizedBox(height: 20,),
                Text('Password',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    controller: passwordController,
                    onsubmit: (){},
                    onchanged: (){},
                    type: TextInputType.visiblePassword,
                    text: ''
                    ,suffixicon: ispassword? IconButton(icon:Icon(Icons.visibility),
                        onPressed:(){
                      setState(() {
                    ispassword=!ispassword;
                  });}):IconButton(icon:Icon(Icons.visibility_off),
                        onPressed:(){setState(() {
                    ispassword=!ispassword;
                  });}),
                    obstext: ispassword,
                    validatortext: 'password must not be empty',

                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.end,
                  children: [TextButton(
                    onPressed: (){},
                    child: Text('Forgot password?',
                      style: TextStyle(color: Colors.grey,),),),],
                ),

                const  SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor('#2e84f5'),
                  ),
                  width: double.infinity,
                  child: MaterialButton(onPressed:(){
                    if(formkey.currentState!.validate()){
                      print('clicked');

                    }
                  },
                    child: Text('Login',
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
                    const  Text('need an account?'),
                    TextButton(onPressed: (){},
                      child: Text('register'),
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
