import 'package:flutter/material.dart';

class TaskNoteScreen extends StatelessWidget {
  const TaskNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Note Task Screen"),
        ),
      ),
    );
  }
}
