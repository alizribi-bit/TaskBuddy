import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../Models/Note.dart';

class NoteManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNoteForProject(
    String projectId,
    String note,
  ) async {
    try {
      await _firestore.collection('notes').add({
        'note': note,
        'createAt': DateFormat('M/d/y H:m:s').format(DateTime.now()),
        'project_id': projectId,
      });
    } catch (e) {
      print('Error adding note for project: $e');
    }
  }

  Future<List<Note>> getNotesForProject(String projectId) async {
    List<Note> notes = [];
    try {
      QuerySnapshot noteSnapshot = await _firestore
          .collection('notes')
          .where('project_id', isEqualTo: projectId)
          .orderBy('createAt', descending: true)
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
    } catch (e) {
      print('Error getting notes for project: $e');
    }
    return notes;
  }
}
