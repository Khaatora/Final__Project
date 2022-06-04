//
//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../shared/components/default_tff.dart';
//
// class Password_Recovary extends StatelessWidget {
//
//   var formkey=GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formkey,
//             child: Column(
//               crossAxisAlignment:CrossAxisAlignment.start ,
//               children: [
//                 Row(
//                   crossAxisAlignment:CrossAxisAlignment.center,
//                   mainAxisAlignment:MainAxisAlignment.center ,
//                   children: const [
//                     Image(image:AssetImage('assets/images/logo.png'),
//                       height: 150,
//                       width: 150,
//                     ),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Enter the email address associated with your acconunt and we will send you a new password',
//                     style: TextStyle(
//                       color: Colors.grey.withRed(124).withGreen(130).withBlue(141),
//                       fontSize: 21,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10,),
//
//
//
//
//                 Text('Email',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
//                   ),
//                 ),
//                 defaulttff(text: 'Email',valtext: 'email address must not be empty',),
//                 SizedBox(height: 70,),
//
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.blue,
//                   ),
//                   width: double.infinity,
//                   child: MaterialButton(onPressed: (){
//                     if(formkey.currentState!.validate()){
//                       print('clicked');
//
//                     }
//                   },
//                     child: const Text('continue',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment:MainAxisAlignment.start ,
//                   children: [
//                     const Text('need an account?'),
//                     TextButton(onPressed: (){},child: const Text('register'),),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//
//
//
//
//
//
//     );
//   }
// }
