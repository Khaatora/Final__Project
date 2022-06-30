import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../board/Back_End/Boardcontroller.dart';
import '../board/Boards_Screen.dart';
import '../login_screen/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 200,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/Group.png'),
                    height: 230,
                    width: 230,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/hexagon-shape-by-Vexels copy 2.png'),
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'make a board to organize anything',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue
                                .withRed(46)
                                .withGreen(132)
                                .withBlue(245),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 195),
                      child: Text(
                        'with anyone',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue
                              .withRed(46)
                              .withGreen(132)
                              .withBlue(245),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/hexagon-shape-by-Vexels copy 2.png'),
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'add task to list in the board and',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue
                                .withRed(46)
                                .withGreen(132)
                                .withBlue(245),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 121),
                      child: Text(
                        'add detail to the task',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue
                              .withRed(46)
                              .withGreen(132)
                              .withBlue(245),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/images/hexagon-shape-by-Vexels copy 2.png'),
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'invite your team to join your board',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue
                                .withRed(46)
                                .withGreen(132)
                                .withBlue(245),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                         boardcontroll().getPublicUserBoards();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text(
                      'start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
