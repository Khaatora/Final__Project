import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class List_Controller extends GetxController {
  //document reference to current accessed BOARD
  DocumentSnapshot? ds;
  //reference to "/Board/BoardOneID/Lists" collection (public lists inside public board)
  CollectionReference<Map<String, dynamic>>? teamLists;
  //reference to /user/UserOneID/Private_Boards/BoardOneID/Private_Lists collection (private lists inside private board)
  CollectionReference<Map<String, dynamic>>? privateLists;
  //snapshot to get BOARD that belong to a certain user
  QuerySnapshot<Map<String, dynamic>>? boardsOfCurrentUser;
  //current signed in user
  User? user = FirebaseAuth.instance.currentUser;
  //list to hold all lists of current signed in user
  static List listOfLists = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  List_Controller({DocumentSnapshot? ds}) {
    teamLists = FirebaseFirestore.instance
        .collection("Board")
        .doc(ds?.id)
        .collection("Lists");
    privateLists = FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private_Boards")
        .doc(ds?.id)
        .collection("Private_Lists");
    this.ds = ds;
  }
  // add LIST to current accessed BOARD, where visibility 1 = PRIVATE , 2 = TEAM
  Future addList(String name) async {
    DocumentReference<Map<String, dynamic>>? docRef;
    if (ds?.get("visibility") == 1) {
      docRef = privateLists!.doc();
      privateLists?.doc(docRef.id).set({
        "ID": name,
        "title": docRef,
      });
    } else {
      docRef = teamLists!.doc();
      teamLists?.doc(docRef.id).set({
        "ID": docRef,
        "title": name,
      });
    }
    return Future(() => docRef);
  }

  //Deletes BOARD that is currently accessed and returns a success string
  Future DeleteBoard() async {
    if (ds?.get("visibility") == 1) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user?.uid)
          .collection("Private_Boards")
          .doc(ds?.id)
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user?.uid)
          .update({
        "Boards": FieldValue.arrayRemove([ds?.id])
      });
      await FirebaseFirestore.instance.collection("Board").doc(ds?.id).update({
        "membersInBoard": FieldValue.arrayRemove([
          {"membership": "admin", "userID": user?.uid},
          {"membership": "member", "userID": user?.uid}
        ])
      });
    }
    return Future(() => "Board Deleted Successfully");
  }

  // stream to keep track of PRIVATE LISTS and continuously update displayed LISTS
  Stream<QuerySnapshot<Map<String, dynamic>>> PReadLists() {
    return privateLists!.orderBy("title").snapshots();
  }

  // stream to keep track of PUBLIC LISTS and continuously update displayed LISTS
  Stream<QuerySnapshot<Map<String, dynamic>>> TReadLists() {
    return teamLists!.orderBy("title").snapshots();
  }

  //get current user's boards (public and private) from firebase and store them in the static list listOfLists
  Future getListMenu(String value) async {
    QuerySnapshot<Map<String, dynamic>> tmpPrivateLists =
        await privateLists!.orderBy("title").get();
    QuerySnapshot<Map<String, dynamic>> tmpPublicLists =
        await teamLists!.orderBy("title").get();
    listOfLists.assignAll(tmpPrivateLists.docs);
    listOfLists.addAll(tmpPublicLists.docs);
    return Future(() => listOfLists);
  }
}
