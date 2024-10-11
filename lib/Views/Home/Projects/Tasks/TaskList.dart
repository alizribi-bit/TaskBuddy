import 'package:flutter/material.dart';

import '../../../../Models/Task.dart';
import 'DragAndDrop/DragDropScreen.dart';

class TaskList extends StatefulWidget {
  final String title;
  final List<TaskModel> tasks;
  final Function(TaskModel) onDragEnd;

  const TaskList(
      {Key? key,
      required this.title,
      required this.tasks,
      required this.onDragEnd})
      : super(key: key);

  @override
  State<TaskList> createState() => TaskListViewState();
}

class TaskListViewState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return DragDropScreen(
      tasks: widget.tasks,
    );
    /* Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ReorderableListView(
            children: widget.tasks.asMap().entries.map((entry) {
              final task = entry.value;

              return LongPressDraggable<TaskModel>(
                data: task, // Pass the TaskModel object as data
                child: TaskWard(task), // Display the task widget
                feedback: TaskWard(
                    task.copyWith(isDragging: true)), // Highlight during drag
                childWhenDragging:
                    const SizedBox(), // Hide original task while dragging
              );
            }).toList(),
            onReorder: (oldIndex, newIndex) {
              // Handle reordering within the same list (optional)
              setState(() {
                final task = widget.tasks.removeAt(oldIndex);
                widget.tasks.insert(
                    newIndex > oldIndex ? newIndex - 1 : newIndex, task);
              });
            },
          ),
        ),
      ],
    ); */
  }
}
