
import 'package:get/get.dart';
import 'Mydata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class boardcontroll extends GetxController {
  CollectionReference<Map<String, dynamic>> Pboards =   FirebaseFirestore.instance.collection("private Boards");
   CollectionReference<Map<String, dynamic>> Tboards =   FirebaseFirestore.instance.collection("Teams boards");
  var list1=<QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  @override
  void onReady() {
    super.onReady();
  }
  addtask({Board? board}) async {


   
if (board!.Visibility == 1) {
         Pboards.add(board.tomap());
    }
  if (board.Visibility == 0) {
         Tboards.add(board.tomap());
    }
 
    }



 



  Stream<QuerySnapshot<Map<String, dynamic>>> PReadBoard() {
  return  FirebaseFirestore.instance.collection("private Boards").orderBy("Priority").snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> TReadBoard() {
  return FirebaseFirestore.instance.collection("Teams boards").orderBy("Priority").snapshots();
  }
   void getBoardmenu()async {

    QuerySnapshot<Map<String, dynamic>>   response1  = await FirebaseFirestore.instance.collection("private Boards").orderBy("Priority").get();
    QuerySnapshot<Map<String, dynamic>>  response2 = await FirebaseFirestore.instance.collection("Teams boards").orderBy("Priority").get();
     list1.assignAll(response1.docs) ;

     list1.addAll(response2.docs);
    print(list1);
}



}


