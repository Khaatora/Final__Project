import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/modules/List/Back_End/List_Controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Mydata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class boardcontroll extends GetxController {
  //current user
  User? user;
  //reference to "Private_Boards" collection
  CollectionReference<Map<String, dynamic>>? Pboards;
  //reference to "Board" collection
  CollectionReference<Map<String, dynamic>>? Tboards;

  /*//reference to "Public_Board_Members" collection
  CollectionReference<Map<String, dynamic>>? Public_Boards_Members;*/

  boardcontroll() {
    this.user = FirebaseAuth.instance.currentUser;
    this.Pboards = FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private_Boards");
    this.Tboards = FirebaseFirestore.instance.collection("Board");

    /*this.Public_Boards_Members =
        FirebaseFirestore.instance.collection("Public_Board_Members");*/
  }
  static List listOfBoards =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  /* static List<Map<String, dynamic>> list2 = <Map<String, dynamic>>[];
  static QuerySnapshot<Map<String, dynamic>>? currentUserBoards;*/
  @override
  void onReady() {
    super.onReady();
  }

  ///add board to database,
  ///and return a future with a document reference of the created board.
  ///visibility = 1 then add to private board, visibility = 0 then add to teams boards
  Future addBoard({Board? board}) async {
    DocumentReference<Map<String, dynamic>>? docRef;
    //pDocName and tDocName are variables used to store a document that contains the passed BOARD title
    if (board!.Visibility == 1) {
      DocumentSnapshot<Map<String, dynamic>>? pDocName = null;
      //get the private board names that match the name from the board to be added
      await Pboards?.where("name", isEqualTo: board.name).get().then((value) =>
          pDocName = value.docs
              .firstWhereOrNull((element) => element["name"] == board.name));
      if (pDocName?["name"] == board.name) {
        throw ArgumentError(
            "You cannot add two boards with the same name", board.name);
      }


      docRef = Pboards!.doc();
      //add document with ID docref and store it inside the fetched collection
      this.Pboards?.doc(docRef.id).set(board.tomap(docRef: docRef));
    } else if (board.Visibility == 0) {
      DocumentSnapshot<Map<String, dynamic>>? tDocName;
      //get the teams board names that match the name from the board to be added
      await Tboards?.where("name", isEqualTo: board.name).get().then((value) =>
          tDocName = value.docs
              .firstWhereOrNull((element) => element["name"] == board.name));
      if (tDocName?["name"] == board.name) {
        throw ArgumentError(
            "You cannot add two boards with the same name", board.name);
      }


      docRef = Tboards!.doc();
      //list to store the board ID
      List l1 = <dynamic>[];
      l1.add(docRef.id);
      //add document with custom ID in the form "userID_docID" and store both IDs inside the doc
      this.Tboards?.doc(docRef.id).set(
          board.tomap(docRef: docRef, membership: "admin", userID: user?.uid));
      //add created board to boards field in user's collection
      FirebaseFirestore.instance.collection("user").doc(user?.uid).update({
        "Boards": FieldValue.arrayUnion(l1),
      });
    }
    List_Controller(ds: await docRef?.get()).addList("Done");
    return Future(() => docRef);
  }

  /// stream to keep track of PRIVATE BOARDS and continuously update displayed BOARDS
  Stream<QuerySnapshot<Map<String, dynamic>>> PReadBoard() {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection('Private_Boards')
        .orderBy("name")
        .snapshots();
  }

  /// stream to keep track of PUBLIC BOARDS and continuously update displayed BOARDS
  Stream<QuerySnapshot<Map<String, dynamic>>> TReadBoard() {
    return FirebaseFirestore.instance
        .collection("Board")
        .where("membersInBoard", arrayContainsAny: [
          {"membership": "admin", "userID": "${user?.uid}"},
          {"membership": "member", "userID": "${user?.uid}"}
        ])
        .orderBy("name")
        .snapshots();
  }

  ///get current user's boards (public and private) from firebase,
  ///and store them in the static list "listOfBoards"
  getBoardMenu() async {
    QuerySnapshot<Map<String, dynamic>> tmpprivateBoards =
        await FirebaseFirestore.instance
            .collection("user")
            .doc(user?.uid)
            .collection("Private_Boards")
            .orderBy("creationDate")
            .get();
    QuerySnapshot<Map<String, dynamic>> tmppublicBoards =
        await FirebaseFirestore.instance
            .collection("Board")
            .where("membersInBoard", arrayContainsAny: [
              {"membership": "admin", "userID": "${user?.uid}"},
              {"membership": "member", "userID": "${user?.uid}"}
            ])
            .orderBy("creationDate")
            .get();
    listOfBoards.assignAll(tmpprivateBoards.docs);
    listOfBoards.addAll(tmppublicBoards.docs);
  }
}
