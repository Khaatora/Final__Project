import 'package:final_pro/modules/board/task.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'Mydata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class boardcontroll  {
  //current user
  User? user;

  //private boards
  CollectionReference<Map<String, dynamic>>? Pboards ;
  //team boards
  CollectionReference<Map<String, dynamic>>? Tboards;

  boardcontroll() {
    this.user = FirebaseAuth.instance.currentUser;
    print(user);
    this.Pboards = FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private Boards");
    this.Tboards = FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Teams Boards");
        
  }
  static var list1 = <QueryDocumentSnapshot<Map<String, dynamic>>>[];


  //add board
  addBoard({Board? board}) async {

    if (board!.Visibility == 1) {
      
      Pboards?.add(board.tomap());
    }
    if (board.Visibility == 0) {
      Tboards?.add(board.tomap());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> PReadBoard() {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection('Private Boards')
        .orderBy("Priority")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> TReadBoard() {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Teams Boards")
        .orderBy("Priority")
        .snapshots();
  }


  void getBoardmenu() async {

    QuerySnapshot<Map<String, dynamic>> response1 = await FirebaseFirestore
        .instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private Boards")
        .orderBy("Priority")
        .get();
    QuerySnapshot<Map<String, dynamic>> response2 = await FirebaseFirestore
        .instance
        .collection("user")
        .doc(user?.uid)
        .collection("Teams Boards")
        .orderBy("Priority")
        .get();
        
    list1.assignAll(response1.docs);

    list1.addAll(response2.docs);

    print(list1);
  }

}
