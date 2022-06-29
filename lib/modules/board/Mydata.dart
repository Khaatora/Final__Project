import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  int? Visibility;
  int? Variable;
  String? name;
  DateTime priority;
  Board({this.name, this.Visibility, required this.priority});


  Map<String, dynamic> tomap(DocumentReference<Map<String, dynamic>> docRef) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['visibilty'] = this.Visibility;
    data['Priority'] = this.priority;
    data['Board_ID'] = docRef.id;
    return data;
  }
}
