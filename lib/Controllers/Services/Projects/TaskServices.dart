import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//import 'package:firebase_auth/firebase_auth.dart';

import '../../../Models/Note.dart';
import '../../../Models/Task.dart';

class TaskManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTaskForProject(String projectId, String name, String priority,
      String? description, String? duDate) async {
    try {
      await _firestore.collection('tasks').add({
        'name': name,
        'priority': priority,
        'description': description,
        'duDate': duDate ?? "",
        'createAt': DateFormat('M/d/y H:m:s').format(DateTime.now()),
        'project_id': projectId,
        'etat': "À Faire"
      });
    } catch (e) {
      print('Error adding task for project: $e');
    }
  }

  Future<List<TaskModel>> getTasksForProject(String projectId) async {
    List<TaskModel> tasks = [];
    try {
      QuerySnapshot taskSnapshot = await _firestore
          .collection('tasks')
          .where('project_id', isEqualTo: projectId)
          .orderBy('priority', descending: true)
          .orderBy('createAt', descending: true)
          .get();

      for (QueryDocumentSnapshot taskDoc in taskSnapshot.docs) {
        List<Note> notes = [];

        QuerySnapshot noteSnapshot = await _firestore
            .collection('notes')
            .where('task_id', isEqualTo: taskDoc.id)
            .orderBy('createAt')
            .get();

        noteSnapshot.docs.forEach((noteDoc) {
          Note note = Note(
            id: noteDoc.id,
            note: noteDoc['note'],
            createAt: noteDoc['createAt'],
            taskId: noteDoc['task_id'],
          );
          notes.add(note);
        });

        TaskModel task = TaskModel(
          id: taskDoc.id,
          name: taskDoc['name'],
          priority: taskDoc['priority'],
          description: taskDoc['description'],
          projectId: taskDoc['project_id'],
          createAt: taskDoc['createAt'],
          duDate: taskDoc['duDate'],
          etat: taskDoc['etat'],
          notes: notes,
        );
        tasks.add(task);
      }
    } catch (e) {
      print('Error getting tasks for project: $e');
    }
    return tasks;
  }
}
