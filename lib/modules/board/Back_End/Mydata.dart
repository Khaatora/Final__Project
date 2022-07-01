import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  int? Visibility;
  int? Variable;
  String? name;
  DateTime? priority;

  Board({this.name, this.Visibility, this.priority});

  Map<String, dynamic> tomap(
      {required DocumentReference<Map<String, dynamic>> docRef,
      String? membership,
      String? userID,
      int? counter = 1}) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (userID != null) {
      data["membersInBoard"] = [{
    "userID" : userID,
    "membership" : membership,
    }];
      data["membersCount"]= counter;
    }
    data['name'] = this.name;
    data['visibilty'] = this.Visibility;
    data['creationDate'] = this.priority;
    data['boardID'] = docRef.id;
    return data;
  }
}
