import 'package:flutter/cupertino.dart';

class Board {
  int? Visibility;
  int? Variable;
  String? name;
  DateTime priority;
  Board({this.name, this.Visibility, required this.priority});

  Map<String, dynamic> tomap() {
     Map<String, dynamic> data = new Map<String, dynamic>();

    data['Name'] = this.name;
    data['visibilty'] = this.Visibility;
    data['Priority'] = this.priority;

    return data;
  }

  static Board fromap(  Map<String, dynamic> data) {
   return Board(
  priority: data['Priority'],
  Visibility:data['visibilty'],
  name:  data['Name']

);
  }
}
