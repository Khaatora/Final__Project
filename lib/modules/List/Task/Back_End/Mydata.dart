import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  int? priority;
  String? name;
  String? attachment;
  DateTime? startDate;
  DateTime? dueDate;
  String? taskDescription;

  Task({this.name, this.priority,this.attachment,this.startDate,this.dueDate});

  Map<String, dynamic> tomap(
      {required DocumentReference<Map<String, dynamic>> docRef,
        String? userID,
        int? counter = 1}) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (userID != null) {
      data["membersInTask"] = [
        {
          "userID": userID,
        }
      ];
      data["membersCount"] = counter;
    }
    data['title'] = this.name;
    data['Task_Description'] = this.taskDescription;
    data['Priority'] = this.priority;
    data['Start_Date'] = this.startDate;
    data['Due_Date'] = this.dueDate;
    data['boardID'] = docRef.id;
    data['Attachment'] = this.attachment;
    return data;
  }
}