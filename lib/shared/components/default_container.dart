import 'package:flutter/material.dart';

Widget defaultContainer({
  required String text,
  required BuildContext context,
  required Widget add,
}) =>
    Expanded(
      child: Container(
        constraints: BoxConstraints.expand(),
        height: MediaQuery.of(context).size.height / 15,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.lightBlue),


        child: Column(
          children: [
            Text('$text',style: TextStyle(color: Colors.grey,fontSize: 40)),
            add,

          ],
        ),
      ),






    );
