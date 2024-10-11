import 'Note.dart';

class TaskModel {
  String? id;
  String? name;
  String? priority;
  String? description;
  String? projectId;
  List<Note>? notes;
  String? createAt;
  String? duDate;
  String? etat;
  bool? isDragging;

  TaskModel({
    this.id,
    this.name,
    this.priority,
    this.description,
    this.projectId,
    this.duDate,
    this.notes,
    this.createAt,
    this.etat,
    this.isDragging = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    description = json['description'];
    projectId = json['projectId'];
    notes = json['notes'];
    createAt = json['createAt'];
    duDate = json['duDate'];
    etat = json['etat'];
  }

  TaskModel copyWith({
    String? id,
    String? name,
    String? priority,
    String? description,
    String? duDate,
    String? createAt,
    String? projectId,
    bool? isDragging,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      duDate: duDate ?? this.duDate,
      createAt: createAt ?? this.createAt,
      projectId: projectId ?? this.projectId,
      isDragging: isDragging ?? this.isDragging,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['priority'] = priority;
    data['description'] = description;
    data['projectId'] = projectId;
    data['notes'] = notes;
    data['createAt'] = createAt;
    data['duDate'] = duDate;
    data['etat'] = etat;
    return data;
  }
}
