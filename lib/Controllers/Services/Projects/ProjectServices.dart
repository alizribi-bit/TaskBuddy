import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Models/Note.dart';
import '../../../Models/Project.dart';
import '../../../Models/Task.dart';

class ProjectManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String>? uploadImageToFirebase(File? imageFile) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');
    UploadTask uploadTask = storageReference.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> addProject(
      String name, String description, File? imageFile, String? date) async {
    try {
      User? user = _auth.currentUser;
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToFirebase(imageFile);
      } else {
        imageUrl = "";
      }
      if (user != null) {
        await _firestore.collection('projects').add({
          'name': name,
          'description': description,
          'createAt': DateFormat('M/d/y H:m:s').format(DateTime.now()),
          'duDate': date ?? "",
          'image': imageUrl ?? "",
          'userId': user.uid,
        });
      } else {
        throw Exception('User not logged in');
      }
      Get.offAllNamed("/homePageScreen");
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  Future<List<Project>> getProjects() async {
    List<Project> projects = [];
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot projectSnapshot = await _firestore
            .collection('projects')
            .where('userId', isEqualTo: user.uid)
            .orderBy('duDate')
            .get();

        for (QueryDocumentSnapshot projectDoc in projectSnapshot.docs) {
          List<TaskModel> tasks = [];
          List<Note> notes = [];

          QuerySnapshot taskSnapshot = await _firestore
              .collection('tasks')
              .where('project_id', isEqualTo: projectDoc.id)
              .orderBy('priority', descending: true)
              .orderBy('createAt', descending: true)
              .get();

          taskSnapshot.docs.forEach((taskDoc) {
            TaskModel task = TaskModel(
              id: taskDoc.id,
              name: taskDoc['name'],
              priority: taskDoc['priority'],
              description: taskDoc['description'],
              projectId: taskDoc['project_id'],
              createAt: taskDoc['createAt'],
              duDate: taskDoc['duDate'],
              etat: taskDoc['etat'],
              notes: [],
            );
            tasks.add(task);
          });

          QuerySnapshot noteSnapshot = await _firestore
              .collection('notes')
              .where('project_id', isEqualTo: projectDoc.id)
              .get();

          noteSnapshot.docs.forEach((noteDoc) {
            Note note = Note(
              id: noteDoc.id,
              note: noteDoc['note'],
              projectId: noteDoc['project_id'],
              createAt: noteDoc['createAt'],
              //taskId: noteDoc['task_id'],
            );
            notes.add(note);
          });

          Project project = Project(
              id: projectDoc.id,
              name: projectDoc['name'],
              description: projectDoc['description'],
              tasks: tasks,
              notes: notes,
              createAt: projectDoc['createAt'],
              image: projectDoc['image'],
              duDate: projectDoc['duDate'],
              uid: user.uid);
          projects.add(project);
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      print('Error getting projects: $e');
    }
    return projects;
  }

  Future<void> deleteProject(String projectId) async {
    try {
      // Delete the project document
      await _firestore.collection('projects').doc(projectId).delete();

      // Delete related tasks
      QuerySnapshot taskSnapshot = await _firestore
          .collection('tasks')
          .where('project_id', isEqualTo: projectId)
          .get();
      for (var taskDoc in taskSnapshot.docs) {
        await taskDoc.reference.delete();
      }

      // Delete related notes
      QuerySnapshot noteSnapshot = await _firestore
          .collection('notes')
          .where('project_id', isEqualTo: projectId)
          .get();
      for (var noteDoc in noteSnapshot.docs) {
        await noteDoc.reference.delete();
      }

      // Optionally, navigate back to the main screen or show a success message
      Get.back(); // Assuming you're using GetX for navigation
    } catch (e) {
      print('Error deleting project: $e');
      // Handle error, e.g., show a toast message
    }
  }
}
