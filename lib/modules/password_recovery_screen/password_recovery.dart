



import 'package:final_pro/modules/sign_up_screen/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/default_tff.dart';

class Password_Recovary extends StatelessWidget {
  var emailController=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [

                    Center(
                      child: Image(image:AssetImage('assets/images/logo.png'),
                        height: 250,
                        width: 250,
                      ),
                    ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Enter the email address associated with your acconunt and we will send you a new password',
                    style: TextStyle(
                      color: Colors.grey.withRed(124).withGreen(130).withBlue(141),
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: 10,),




                Text('Email',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  height:  MediaQuery.of(context).size.height/20,
                  child: defaulttff(context: context,
                    controller:emailController,
                    onsubmit: (){},
                    onchanged: (){},
                    text: '',
                    validatortext: 'email address must not be empty',
                  type: TextInputType.text,

                  ),
                ),
                SizedBox(height: 30,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),

                  child: MaterialButton(onPressed: (){
                    if(formkey.currentState!.validate()){
                      print('clicked');

                    }
                  },
                    child: const Text('continue',
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
                    const Text('need an account?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_Up()));
                    },child: const Text('register'),),
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
