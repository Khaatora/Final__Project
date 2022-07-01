import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/modules/login_screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/components/default_tff.dart';
import '../board/Boards_Screen.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  bool ispassword = true;
  bool ispassword2 = true;
  bool ismatch = true;

  bool loading = false;

  String imageUrl = '';

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   SizedBox(
                //    height: 20,
                // ),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 200,
                    width: 200,
                  ),
                ),
                Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: defaulttff(
                        context: context,
                        text: '',
                        validatortext: 'username must not be empty',
                        controller: usernameController,
                        onsubmit: () {
                          print(usernameController.text);
                        },
                        onchanged: () {},
                        type: TextInputType.text)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: defaulttff(
                        context: context,
                        text: '',
                        validatortext: 'Email address must not be empty',
                        controller: emailController,
                        onsubmit: () {},
                        onchanged: () {},
                        type: TextInputType.text)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: defaulttff(
                    context: context,
                    controller: passwordController,
                    onsubmit: () {},
                    onchanged: () {},
                    type: TextInputType.visiblePassword,
                    text: '',
                    validatortext: 'password must not be empty',
                    obstext: ispassword,
                    suffixicon: ispassword
                        ? IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            })
                        : IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Confirm password',
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#2e84f5'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: defaulttff(
                    context: context,
                    controller: cpasswordController,
                    onsubmit: () {},
                    onchanged: () {},
                    type: TextInputType.visiblePassword,
                    text: '',
                    validatortext: ismatch ? '' : 'password must match',
                    obstext: ispassword2,
                    suffixicon: ispassword2
                        ? IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                ispassword2 = !ispassword2;
                              });
                            })
                        : IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                ispassword2 = !ispassword2;
                              });
                            }),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor('#2e84f5'),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (cpasswordController.text ==
                            passwordController.text) {
                          ismatch = true;
                          print(ismatch);
                        } else if (cpasswordController.text !=
                            passwordController.text) {
                          ismatch = false;
                          print(ismatch);
                        }
                      });
                      if (formkey.currentState != null &&
                          formkey.currentState!.validate()) {
                        _signUp();
                        Login login = new Login();
                      }

                      if (formkey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'sign up',
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
                    const Text('already a user?'),
                    Container(
                      width: MediaQuery.of(context).size.width / 8,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text('login'),
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

  Future _signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
        'username': usernameController.text,
        'email': emailController.text,
        'imageUrl': imageUrl,
      });
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign up succeeded'),
                content: Text('Your account was created, you can now log in'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _logIn();
                      },
                      child: Text('Ok'))
                ],
              ));
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() {
        loading = false;
      });
    }
  }

  _logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => fun()));
    } on FirebaseAuthException catch (e) {
      String message = "";
      switch (e.code) {
        case 'invalid-email':
          message = "The Email you entered is invalid";
          break;
        case 'user-disabled':
          message = "The User you tried to log into is disabled";
          break;
        case 'user-not-found':
          message = "The User you tried to log into was not found";
          break;
        case 'wrong-password':
          message = "Incorrect password";
          break;
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('log in failed'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ok')),
              ],
            );
          });
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use';
        break;
      case 'invalid-email':
        messageToDisplay = 'The Email you entered is invalid';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed';
        break;
      case 'weak-password':
        messageToDisplay = 'The password you entered is too weak';
        break;
      default:
        messageToDisplay = 'An unknown error occured';
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Sign up failed'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }
}
