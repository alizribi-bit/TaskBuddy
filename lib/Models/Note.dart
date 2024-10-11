class Note {
  String? id;
  String? createAt;
  String? note;
  String? projectId;
  String? taskId;

  Note({this.id, this.note, this.projectId, this.taskId, this.createAt});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    createAt = json['createAt'];
    projectId = json['projectId'];
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['createAt'] = this.createAt;
    data['projectId'] = this.projectId;
    data['taskId'] = this.taskId;
    return data;
  }
}
