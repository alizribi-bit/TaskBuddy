import 'Note.dart';
import 'Task.dart';

class Project {
  String? id;
  String? name;
  String? description;
  String? image;
  String? duDate;
  List<TaskModel>? tasks;
  List<Note>? notes;
  String? uid;
  String? createAt;

  Project({
    this.id,
    this.name,
    this.description,
    this.tasks,
    this.notes,
    required this.uid,
    this.createAt,
    this.duDate,
    this.image,
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    description = json['description'];
    createAt = json['createAt'];
    image = json['image'];
    duDate = json['duDate'];
    tasks =
        List<TaskModel>.from(json['tasks'].map((x) => TaskModel.fromJson(x)));
    notes = List<Note>.from(json['notes'].map((x) => Note.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['description'] = description;
    data['createAt'] = createAt;
    data['image'] = image;
    data['duDate'] = duDate;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
