import 'package:todo_app/models/index.dart';

class Task {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? taskName;
  String? description;
  TaskLevel? level;
  TaskStatus? status;
  String? createdBy;
  String? updatedBy;
  String? estimatedDate;
  String? finishedDate;

  UserData? userCreated;
  UserData? userUpdated;

  Task({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.taskName,
    this.description,
    this.level,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.userCreated,
    this.userUpdated,
    this.estimatedDate,
    this.finishedDate,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taskName = json['task_name'];
    description = json['description'];
    level = json['level'] != null ? TaskLevel.values[json['level']] : json['level'];
    status = json['status'] != null ? TaskStatus.values[json['status']] : json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    estimatedDate = json['estimated_date'];
    finishedDate = json['finished_date'];
    userCreated = json['user_created'] != null ? UserData.fromJson(json['user_created']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'task_name': taskName,
      'description': description,
      'level': level?.index,
      'status': status?.index,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'estimated_date': estimatedDate,
      'finished_date': finishedDate,
    };
  }
}

enum TaskStatus { pending, completed, cancelled }

enum TaskLevel { low, medium, high }
