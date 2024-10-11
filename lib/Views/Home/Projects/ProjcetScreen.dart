import 'package:flutter/material.dart';
import '../../../Models/Project.dart';

import 'Details/ProjectDetails.dart';
import 'Notes/NoteScreen.dart';
import 'Tasks/TaskScreen.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key, required this.project});
  final Project project;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Project"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Project"),
              Tab(text: "Task's"),
              Tab(text: "Note's")
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ProjectDetails(
              project: widget.project,
            ),
            TaskScreen(
              project: widget.project,
            ),
            NoteScreen(
              project: widget.project,
            ),
          ],
        ),
      ),
    );
  }
}
