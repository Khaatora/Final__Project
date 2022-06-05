

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_screen/login.dart';




class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(

          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [



                  Center(
                    child: Image(image:AssetImage('assets/images/logo.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),



             Padding(
               padding: const EdgeInsets.only(right: 30),
               child: Center(
                 child: Image(image:AssetImage('assets/images/Group.png'),
                      height: 250,
                      width: 250,
                    ),
               ),
             ),



              Column(
                children: [
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/hexagon-shape-by-Vexels copy 2.png'),),
                     SizedBox(width: 10,),
                      Text('make a board to organize anything',

                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text('with any one',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                      ),
                    ),
                  ),
                ],
              ),





              const SizedBox(height: 10,),
              Column(
                children: [
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/hexagon-shape-by-Vexels copy 2.png'),),
                      SizedBox(width: 10,),
                      Text('add task to list in the board and',

                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: Text('add detail to the task',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(children: [

                Image(image:AssetImage('assets/images/hexagon-shape-by-Vexels copy 2.png'),),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text('invite your team to join your board',

                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                      ),
                    ),

                  ],
                ),
              ],
              ),
              const SizedBox(height: 20,),
              Center(
                child: Container(
                 width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.withRed(46).withGreen(132).withBlue(245),
                  ),



                  child: MaterialButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                  },
                    child: const Text('start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),



                ),
              ),
              Center(
                child: Container(

                  height: MediaQuery.of(context).size.height/15,

                  child: Image(image:AssetImage('assets/images/bold-Vexels.png'),
                    height: 120,
                    width: 120,
                  ),
                ),
              ),



            ],
          ) ,
        ),
      ),







    );
  }
}
