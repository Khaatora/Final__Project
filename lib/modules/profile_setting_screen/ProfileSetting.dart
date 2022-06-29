import 'dart:io';

import 'package:final_pro/modules/successlistcubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/default_tff.dart';

import '../welcome_screen/welcome.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileSetting extends StatefulWidget {
  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  var isOn;
  bool ispassword = true;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var cpasswordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  File? imageUrl;

  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.imageUrl = imagetemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/hexagon10.png",
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 1.2),
                      child: IconButton(
                        icon: Icon(Icons.brightness_4_outlined,
                            color: Colors.black),
                        onPressed: () {
                          SucessListCubit.get(context).changeappmode();
                        },
                      ),
                    ),
                    HexagonWidget.flat(
                      width: 100,
                      color: HexColor('#889EB4'),
                      padding: 4.0,
                      child: imageUrl != null
                          ? Image.file(imageUrl!)
                          : FlutterLogo(
                              size: 100,
                            ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          pickimage();
                        },
                        child: Text('Change Profile Picture'),
                      ),
                    ),
                    Text(
                      'username',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: defaulttff(
                        context: context,
                        controller: usernameController,
                        onsubmit: () {},
                        onchanged: () {},
                        type: TextInputType.text,
                        text: '',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'email',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'change password',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: defaulttff(
                        context: context,
                        controller: cpasswordController,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: HexColor('#7c828d'),
                    ),
                    Text(
                      'Notification',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Open system setting',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: HexColor('#7c828d'),
                    ),
                    Text(
                      'support',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#7c828d'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terms of service',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome()));
                          },
                          child: const Text(
                            'Log out',
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
