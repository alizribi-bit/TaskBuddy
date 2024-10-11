import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../Models/Task.dart';
import '../Widget/TaskWidget.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key, required this.tasks});

  final List<TaskModel> tasks;
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateTaskStatus(TaskModel task, String newStatus) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(task.id)
          .update({'etat': newStatus});
      //setState(() {});
      // Update local task lists based on new status
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  List<TaskModel> _toDoTasks = [];
  List<TaskModel> _inProgressTasks = [];
  List<TaskModel> _completedTasks = [];

  @override
  void initState() {
    _toDoTasks = widget.tasks.where((task) => task.etat == 'À Faire').toList();
    _inProgressTasks =
        widget.tasks.where((task) => task.etat == 'En Cours').toList();
    _completedTasks =
        widget.tasks.where((task) => task.etat == 'Terminé').toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Positioned(
            height: MediaQuery.sizeOf(context).height * .3,
            width: MediaQuery.sizeOf(context).width,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("À Faire"),
                  buildDarg(_toDoTasks, "À Faire"),
                ],
              ),
            ),
          ),
          Positioned(
            height: MediaQuery.sizeOf(context).height * .31,
            width: MediaQuery.sizeOf(context).width,
            top: MediaQuery.sizeOf(context).height * .27,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("En Cours"),
                  buildDarg(_inProgressTasks, "En Cours"),
                ],
              ),
            ),
          ),
          Positioned(
            height: MediaQuery.sizeOf(context).height * .3,
            width: MediaQuery.sizeOf(context).width,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Terminé"),
                  buildDarg(_completedTasks, "Terminé"),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void myFunction(draggedData) {
    // Your function logic here
    print('Function launched after drag completion');
  }

  Widget buildDarg(List<TaskModel> data, String category) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: DragTarget<TaskModel>(
        builder: (context, candidateData, rejectedData) {
          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return LongPressDraggable<TaskModel>(
                data: data[index],
                feedback: Material(
                  elevation: 4.0,
                  child: TaskWard(
                    data[index],
                  ),
                ),
                childWhenDragging: TaskWard(data[index]),
                onDragStarted: () {
                  print('Drag started for ${data[index].name!}');
                },
                onDragCompleted: () {
                  print('Drag completed for ${data[index].name!}');
                  switch (category) {
                    case 'À Faire':
                      _toDoTasks.remove(data[index]);
                      break;
                    case 'En Cours':
                      _inProgressTasks.remove(data[index]);

                      break;
                    case 'Terminé':
                      _completedTasks.remove(data[index]);
                      break;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: TaskWard(data[index]),
                ),
              );
            },
          );
        },
        onAccept: (receivedData) {
          switch (category) {
            case 'À Faire':
              _toDoTasks.add(receivedData);
              _updateTaskStatus(receivedData, category);
              break;
            case 'En Cours':
              _inProgressTasks.add(receivedData);
              _updateTaskStatus(receivedData, category);
              break;
            case 'Terminé':
              _completedTasks.add(receivedData);
              _updateTaskStatus(receivedData, category);
              break;
          }
          setState(() {});
        },
      ),
    );
  }
}
