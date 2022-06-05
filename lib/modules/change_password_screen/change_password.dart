






import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/default_tff.dart';

import '../welcome_screen/welcome.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  var isOn;
  bool ispassword=true;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var cpasswordController = TextEditingController();
  var formkey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(

          image: AssetImage("assets/images/hexagon10.png",
          ),
    fit: BoxFit.values[0],
    ),
          ),


          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 350),
                      child: Icon(Icons.brightness_4_outlined,
                          color: Colors.black),
                    ),

                    HexagonWidget.flat(
                      width: 100,
                      color: HexColor('#889EB4'),
                      padding: 4.0,
                      child: Image(
                        height: 300,
                        width: 300,
                        image: NetworkImage('https://bin.yhdistysavain.fi/1575260/MbR2E7GAwCNq2SYSbQez0StVh6/HabdaSq.png'),),
                    ),
                    Center(child: TextButton(onPressed: (){}, child: Text('Change Profile Picture'))),


                    Text('username',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),


                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: defaulttff(
                        controller: usernameController,
                        onsubmit: () {},
                        onchanged: () {},
                        type: TextInputType.text,
                        text: '',
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text('email',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: defaulttff(controller: emailController,
                        onsubmit: () {},
                        onchanged: () {},
                        type: TextInputType.text,
                        text: '',
                      ),
                    ),

                    SizedBox(height: 20,),


                    Text('change password',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: defaulttff(
                        controller: cpasswordController,
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




                    SizedBox(height: 10,),


                    Container(
                      height: 2,
                      width: double.infinity,
                      color: HexColor('#7c828d'),
                    ),
                    Text('Notification',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),


                    ),
                    TextButton(onPressed: () {}, child: Text('Open system setting',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),


                    ),),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: HexColor('#7c828d'),
                    ),

                    Text('support',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),


                    ),
                    TextButton(onPressed: () {}, child: Text('Contact Us',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),


                    ),),
                    TextButton(onPressed: () {}, child: Text('Privacy Policy',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),


                    ),),
                    TextButton(onPressed: () {}, child: Text('Terms of service',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),


                    ),),
                    Center(

                      child: Container(
                      width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),



                        child: MaterialButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Welcome()));
                        },
                          child: const Text('Log out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
