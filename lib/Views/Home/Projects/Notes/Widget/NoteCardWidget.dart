import 'package:flutter/material.dart';

import '../../../../../Models/Note.dart';

Widget NoteCard(Note note) {
  return SizedBox(
    width: 100,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          note.note!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}
