import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(actions: [
   Container(
    decoration: BoxDecoration(
         color: Color.fromARGB(255, 184, 182, 182),
         borderRadius: BorderRadius.circular(20)
    ), 
    
      
   )

   ]),
    body:Column(children: [
      
    ],) ,




    );
  }
}