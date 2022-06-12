import 'package:get/get.dart';
import 'MyData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class boardcontroll extends GetxController{
  CollectionReference<Map<String, dynamic>> boards = FirebaseFirestore.instance.collection("Boards");
  FirebaseFirestore firebase = FirebaseFirestore.instance;


 @override
 void onReady(){
   super.onReady();
 }
  Future<DocumentReference<Map<String, dynamic>>> addtask({Board? board})async=> await boards.add(board!.tomap());
 
 
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadBoard()=> firebase.collection("Boards").snapshots();
 




 
  
}