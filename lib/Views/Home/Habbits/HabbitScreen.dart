import 'package:flutter/material.dart';

import '../Projects/Tasks/DragAndDrop/DragDropScreen.dart';

class HabbitScreen extends StatelessWidget {
  const HabbitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DragDropScreen(
        tasks: [],
      )),
    );
  }
}
