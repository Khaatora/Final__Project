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
      String? userID}) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (userID != null) {
      data["Users_In_Board"] = [userID];
    }
    data['Name'] = this.name;
    data['visibilty'] = this.Visibility;
    data['Priority'] = this.priority;
    data['Board_ID'] = docRef.id;
    return data;
  }
}
