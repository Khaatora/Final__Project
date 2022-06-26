import 'package:final_pro/modules/change_password_screen/change_password.dart';
import 'package:final_pro/modules/password_recovery_screen/password_recovery.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/components/default_tff.dart';
import '../board/borads.dart';
import '../sign_up_screen/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formkey = new GlobalKey<FormState>();
  bool ispassword = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
//function to verify user sign in info and change screen into home screen
    _logIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>fun()));
      }
      on FirebaseAuthException catch (e) {
        String message="";
        switch (e.code) {
          case 'invalid-email':
            message = "The Email you entered is invalid";
            break;
          case 'user-disabled':
            message = "The User you tried to log into is disabled";
            break;
          case 'user-not-found':
            message ="The User you tried to log into was not found";
            break;
          case 'wrong-password':
            message ="Incorrect password";
            break;
        }

        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('log in failed'),
            content: Text(message),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('ok')),
            ],
          );
        });
      }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Center(
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Email',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    context: context,
                    controller: emailController,
                    onsubmit: () {},
                    onchanged: () {},
                    type: TextInputType.text,
                    text: '',
                    validatortext: 'email address must not be empty',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: defaulttff(
                    context: context,
                    controller: passwordController,
                    onsubmit: () {},
                    onchanged: () {},
                    type: TextInputType.visiblePassword,
                    text: '',
                    suffixicon: ispassword
                        ? IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            })
                        : IconButton(
                            icon: Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            }),
                    obstext: ispassword,
                    validatortext: 'password must not be empty',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Password_Recovary()));
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor('#2e84f5'),
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {

                      if (formkey.currentState!.validate()) {
                        _logIn();
                        print('clicked');
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('need an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_Up()));
                      },
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
