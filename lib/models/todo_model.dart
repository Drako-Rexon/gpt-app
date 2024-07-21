import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String task;
  bool isDone;
  String phoneNumber;
  Timestamp createdOn;
  Timestamp updatedOn;

  TodoModel({
    required this.task,
    required this.phoneNumber,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
  });

  TodoModel.fromJson(Map<String, Object?> json)
      : this(
          task: json['task']! as String,
          isDone: json['isDone']! as bool,
          phoneNumber: json['phoneNumber']! as String,
          createdOn: json['createdOn']! as Timestamp,
          updatedOn: json['updatedOn']! as Timestamp,
        );

  TodoModel copyWith(
      {String? task, String? phoneNumber, isDone, createdOn, updatedOn}) {
    return TodoModel(
        task: task ?? this.task,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isDone: isDone ?? this.isDone,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn);
  }

  Map<String, Object?> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'phoneNumber': phoneNumber,
      'createdOn': createdOn,
      'updatedOn': updatedOn
    };
  }
}
