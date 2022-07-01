import 'package:cloud_firestore/cloud_firestore.dart';
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
  static List listOfBoards = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  /* static List<Map<String, dynamic>> list2 = <Map<String, dynamic>>[];
  static QuerySnapshot<Map<String, dynamic>>? currentUserBoards;*/
  @override
  void onReady() {
    super.onReady();
  }

  //add board, visibility = 1 then add to private board, visibility = 0 then add to teams boards
  addBoard({Board? board}) async {
    if (board!.Visibility == 1) {
      //generate documentID for custom document ID
      DocumentReference<Map<String, dynamic>> docRef = Pboards!.doc();
      //add document with ID docref and store it inside the created document
      this.Pboards?.doc(docRef.id).set(board.tomap(docRef: docRef));
    }
    if (board.Visibility == 0) {
      //generate documentID for custom document ID
      DocumentReference<Map<String, dynamic>> docRef = Tboards!.doc();
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
  }

  /*getPublicUserBoards() async{
    var tempList1 = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
    Stream<QuerySnapshot<Map<String, dynamic>>> tmpSnp;
    var tempsnp = await FirebaseFirestore.instance
        .collection("Public_Board_Members").where("User_ID", isEqualTo: user?.uid).get();
    tempList1.assignAll(tempsnp.docs);
    tempList1.forEach((element) {
     tmpSnp. Tboards!.where("Board_ID", isEqualTo: element["Board_ID"]).snapshots();
    });
    return tmpSnp;
  }*/

  /*getPublicUserBoards() async {
    List<String> tmplist1 = <String>[];
    List<Map<String, dynamic>> tmplist2 = <Map<String, dynamic>>[];
    QuerySnapshot<Map<String, dynamic>> response1 = await Public_Boards_Members!
        .where("User_ID", isEqualTo: user?.uid)
        .get();
    QuerySnapshot<Map<String, dynamic>> response2 =
        await Tboards!.orderBy("Priority").get();
    var x = response1.docs.map((e) => e.data()).toList();
    var y = response2.docs.map((e) => e.data()).toList();

    x.forEach((element) {
      tmplist1.add(element["Board_ID"]);
    });
    y.forEach((element) {
      if (tmplist1.contains(element["Board_ID"])) {
        tmplist2.add(element);
      }
    });
    list2 = tmplist2;
  }*/
  // stream to keep track of PRIVATE BOARDS and continuously update displayed BOARDS
  Stream<QuerySnapshot<Map<String, dynamic>>> PReadBoard() {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .collection('Private_Boards')
        .orderBy("creationDate")
        .snapshots();
  }
  
  // stream to keep track of PUBLIC BOARDS and continuously update displayed BOARDS
  Stream<QuerySnapshot<Map<String, dynamic>>> TReadBoard() {
    return FirebaseFirestore.instance
        .collection("Board")
        .where("membersInBoard", arrayContainsAny: [
      {"membership": "admin", "userID": "${user?.uid}"},
      {"membership": "member", "userID": "${user?.uid}"}
    ]).orderBy("creationDate").snapshots();
  }
  
  Stream<QuerySnapshot<Map<String, dynamic>>> Lists(String boardId) {
    return Tboards!
        .doc("$boardId")
        .collection("Lists").snapshots();
  }


  //get current user's boards (public and private) from firebase
  getBoardMenu() async {
    QuerySnapshot<Map<String, dynamic>> tmpprivateBoards = await FirebaseFirestore
        .instance
        .collection("user")
        .doc(user?.uid)
        .collection("Private_Boards")
        .orderBy("creationDate")
        .get();
    QuerySnapshot<Map<String, dynamic>> tmppublicBoards = await FirebaseFirestore
        .instance
        .collection("Board")
        .where("membersInBoard", arrayContainsAny: [
      {"membership": "admin", "userID": "${user?.uid}"},
      {"membership": "member", "userID": "${user?.uid}"}
    ]).orderBy("creationDate").get();
    listOfBoards.assignAll(tmpprivateBoards.docs);
    listOfBoards.addAll(tmppublicBoards.docs);
  }
}
