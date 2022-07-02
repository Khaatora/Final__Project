import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Mydata.dart';

class Task_Controller extends GetxController {
  //document reference to current accessed LIST
  DocumentSnapshot? ds;
  //reference to "/Board/BoardOneID/Lists/ListOneID/TaskOneID" collection (public tasks inside public board)
  CollectionReference<Map<String, dynamic>>? teamTasks;
  //reference to /user/UserOneID/Private_Boards/BoardOneID/Private_Lists/ListOneID/Private_Task collection (private tasks inside private board)
  CollectionReference<Map<String, dynamic>>? privateTasks;
  //current signed in user
  User? user = FirebaseAuth.instance.currentUser;
  //list to hold all lists of current signed in user
  static List listOfTasks = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  Task_Controller(DocumentSnapshot? listDoc, String docID ) {
    this.ds = listDoc;
    teamTasks = FirebaseFirestore.instance
        .collection("Board")
        .doc(ds?.id)
        .collection("Lists").doc(docID).collection("Team_Tasks");
    privateTasks = FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private_Boards")
        .doc(ds?.id)
        .collection("Private_Lists").doc(docID).collection("Private_Tasks");
  }

  // add LIST to current accessed BOARD, where visibility 1 = PRIVATE , 2 = TEAM
  Future addTask({Task? task1}) async {
    DocumentReference<Map<String, dynamic>>? docRef;
    if (ds?.get("visibility") == 1) {
      DocumentSnapshot<Map<String, dynamic>>? pDocName = null;
      //get the private board names that match the name from the board to be added
      await privateTasks?.where("name", isEqualTo: task1?.name).get().then((value) =>
      pDocName = value.docs
          .firstWhereOrNull((element) => element["name"] == task1?.name));
      if (pDocName?["name"] == task1?.name) {
        throw ArgumentError(
            "You cannot add two boards with the same name", task1?.name);
      }

      docRef = privateTasks!.doc();
      //add Task with custom ID into private Tasks
      privateTasks?.doc(docRef.id).set(
        task1!.tomap(docRef: docRef)
      );
    } else {
      DocumentSnapshot<Map<String, dynamic>>? tDocName;
      //get the teams board names that match the name from the board to be added
      await teamTasks?.where("name", isEqualTo: task1?.name).get().then((value) =>
      tDocName = value.docs
          .firstWhereOrNull((element) => element["name"] == task1?.name));
      if (tDocName?["name"] == task1?.name) {
        throw ArgumentError(
            "You cannot add two boards with the same name", task1?.name);
      }

      docRef = teamTasks!.doc();
      //list to store the board ID
      List l1 = <dynamic>[];
      l1.add(docRef?.id);
      teamTasks?.doc(docRef.id).set(
        task1!.tomap(docRef: docRef, userID: user?.uid));
      //add created board to boards field in user's collection
      FirebaseFirestore.instance.collection("user").doc(user?.uid).update({
        "Tasks": FieldValue.arrayUnion(l1),
      });
    }
    return Future(() => docRef);
  }


}