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

  List_Controller({required DocumentSnapshot? ds}) {
    this.ds = ds;
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
  }

  //TODO add default list called done that takes all done tasks

  /// add LIST to current accessed BOARD, where visibility 1 = PRIVATE , 2 = TEAM, 
  /// and returns a future that contains the list's documentID
  Future addList(String name) async {
    //variable to store document reference of the created list's document
    DocumentReference<Map<String, dynamic>>? docRef;

    //pDocName and tDocName are variables used to store a document that contains the passed LIST title
    if (ds?.get("visibility") == 1) {
      DocumentSnapshot<Map<String, dynamic>>? pDocName = null;
      //get the private board names that match the name from the board to be added
      await teamLists?.where("title", isEqualTo: name).get().then((value) =>
      pDocName = value.docs
          .firstWhereOrNull((element) => element["title"] == name));
      if (pDocName?["title"] == name) {
        throw ArgumentError(
            "You cannot add two lists with the same name", name);
      }

      docRef = privateLists!.doc();
      privateLists?.doc(docRef.id).set({"ID": docRef.id, "title": name});
    } else {
      DocumentSnapshot<Map<String, dynamic>>? tDocName;
      //get the teams board names that match the name from the board to be added
      await teamLists?.where("title", isEqualTo: name).get().then((value) =>
      tDocName = value.docs
          .firstWhereOrNull((element) => element["title"] == name));
      if (tDocName?["title"] == name) {
        throw ArgumentError(
            "You cannot add two lists with the same name", name);
      }


      docRef = teamLists!.doc();
      teamLists?.doc(docRef.id).set({"ID": docRef.id, "title": name});
    }
    return Future(() => docRef);
  }

  //TODO deleteList()
  Future DeleteList(String name) async{

  }

  ///add user to the board,
  ///and returns a future that contains a success string
  Future AddUserToBoard(String Email) async{
    try{
      if(Email !=  user?.email){
        String ?tmpUserID;
        await FirebaseFirestore.instance
            .collection("user")
            .where("email", isEqualTo: Email).get().then((value) => value.docs.forEach((element) {
          tmpUserID = element.id;
          element.reference.update({
            "Boards": FieldValue.arrayUnion([ds?.id])
          });}));
        await FirebaseFirestore.instance.collection("Board").doc(ds?.id).update({
          "membersInBoard": FieldValue.arrayUnion([
            {"membership": "admin", "userID": tmpUserID},
            {"membership": "member", "userID": tmpUserID}
          ])
        });
        return Future(() => "${Email} joined board");
      }
      throw ArgumentError("You cannot add yourself.");
    }
    on ArgumentError catch(e){
      print(e.message);
    }
    catch(e){
      print(e);
    }
  }

  ///removes user from the board,
  ///and returns a future that contains success string.
  ///if the board is empty, the board is deleted as well
  Future DeleteUserFromBoard(String Email) async{
    try{
      if(Email !=  user?.email){
        String ?tmpUserID;
        await FirebaseFirestore.instance
            .collection("user")
            .where("email", isEqualTo: Email).get().then((value) => value.docs.forEach((element) {
          tmpUserID = element.id;
          element.reference.update({
            "Boards": FieldValue.arrayRemove([ds?.id])
          });}));
        await FirebaseFirestore.instance.collection("Board").doc(ds?.id).update({
          "membersInBoard": FieldValue.arrayRemove([
            {"membership": "admin", "userID": tmpUserID},
            {"membership": "member", "userID": tmpUserID}
          ])
        });
        await FirebaseFirestore.instance
            .collection("Board")
            .where("membersInBoard", isEqualTo: [])
            .get()
            .then((value) => value.docs.forEach((element) {
          element.reference.delete();
        }));
        return Future(() => "${Email} left board");
      }
      throw ArgumentError("You cannot remove yourself, if you want to just leave the board.");
    }
    on ArgumentError catch(e){
      print(e.message);
    }
    catch(e){
      print(e);
    }
  }

  ///Leaves BOARD that is currently accessed,
  ///and returns a future that contains success string
  Future LeaveBoard() async {
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
      await FirebaseFirestore.instance
          .collection("Board")
          .where("membersInBoard", isEqualTo: [])
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));
    }
    return Future(() => "${user?.email} left board");
  }

  ///Deletes BOARD that is currently accessed,
  ///and returns a future that contains a success string
  Future DeleteBoard() async {
    //list to keep
    List<String> l1 = [];
    //if board is private then delete board from user's "Private_Boards" collection.
    if (ds?.get("visibility") == 1) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user?.uid)
          .collection("Private_Boards")
          .doc(ds?.id)
          .delete();
      //if board is public then delete board from user's "Board" array, and from Board's "membersInBoard" array
    } else {
      await FirebaseFirestore.instance
          .collection("user")
          .where("Boards", arrayContains: ds?.id)
          .get()
          .then((value) => value.docs.forEach((element) {
                l1.add(element.id);
                print(element.id);
                element.reference.update({
                  "Boards": FieldValue.arrayRemove([ds?.id])
                });
              }));
      await FirebaseFirestore.instance.collection("Board").doc(ds?.id).delete();
    }
    return Future(() => "Board Deleted Successfully");
  }

  /// stream to keep track of PRIVATE LISTS and continuously update displayed LISTS
  Stream<QuerySnapshot<Map<String, dynamic>>> PReadLists() {
    return privateLists!.orderBy("title").snapshots();
  }

  /// stream to keep track of PUBLIC LISTS and continuously update displayed LISTS
  Stream<QuerySnapshot<Map<String, dynamic>>> TReadLists() {
    return teamLists!.orderBy("title").snapshots();
  }

  ///get current user's lists (public and private) from firebase,
  ///and store them in the static list "listOfLists"
  static Future getListMenu(
      String value, DocumentSnapshot ds, User? user) async {
    QuerySnapshot<Map<String, dynamic>> tmpPrivateLists =
        await FirebaseFirestore.instance
            .collection("user")
            .doc(user?.uid)
            .collection("Private_Boards")
            .doc(ds.id)
            .collection("Private_Lists")
            .where("title", isEqualTo: value)
            .orderBy("title")
            .get();
    QuerySnapshot<Map<String, dynamic>> tmpPublicLists = await FirebaseFirestore
        .instance
        .collection("Board")
        .doc(ds.id)
        .collection("Lists")
        .where("title", isEqualTo: value)
        .orderBy("title")
        .get();
    listOfLists.assignAll(tmpPrivateLists.docs);
    listOfLists.addAll(tmpPublicLists.docs);
    return Future(() => listOfLists);
  }
}
