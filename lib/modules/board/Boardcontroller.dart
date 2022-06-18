import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Mydata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class boardcontroll extends GetxController{
  CollectionReference<Map<String, dynamic>> Pboards = FirebaseFirestore.instance.collection("Boards");
  FirebaseFirestore firebase = FirebaseFirestore.instance;


 @override
 void onReady(){
   super.onReady();
 }
  

 addtask({Board? board})async {


  await Pboards.add(board!.tomap());
  


 

 }
 
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadBoard()=> firebase.collection("Boards").orderBy("Priority").snapshots();





 
  
}


