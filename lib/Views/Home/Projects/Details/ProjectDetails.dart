import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../Models/Project.dart';
import '../../../Widget/ProjectWidget.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required Project this.project});
  final Project project;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity * .5,
          child: projectWidget(
            widget.project,
            () {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
