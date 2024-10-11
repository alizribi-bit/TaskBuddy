import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../Controllers/Services/Projects/TaskServices.dart';
import '../../../../Models/Project.dart';
import '../../../../Models/Task.dart';
import '../../../../Setting/Colors.dart';
import '../../../../Setting/Style/Style.dart';
import 'DragAndDrop/DragDropScreen.dart';
import 'Widget/TaskWidget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.project});
  final Project project;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> tasks = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _duDateController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();

  void _addTask() {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String priority = _priorityController.text;

    if (name.isNotEmpty && description.isNotEmpty && priority.isNotEmpty) {
      TaskManager().addTaskForProject(widget.project.id.toString(), name,
          priority, description, _duDateController.text);
      // You can add navigation or feedback here after adding the project
    } else {
      // Handle validation or show error message if fields are empty
    }
  }

  TaskManager fetchedProjects = TaskManager();

  String selectedPriority = 'LOW';
  List<String> priorities = ['LOW', 'MEDIUM', 'HIGH'];
  bool isChecked = true;

  List<TaskModel> _toDoTasks = [];
  List<TaskModel> _inProgressTasks = [];
  List<TaskModel> _completedTasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateTaskStatus(TaskModel task, String newStatus) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(task.id)
          .update({'etat': newStatus});
      // Update local task lists based on new status
      _updateLocalLists(task, newStatus);
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  void _updateLocalLists(TaskModel task, String newStatus) {
    _toDoTasks.remove(task);
    _inProgressTasks.remove(task);
    _completedTasks.remove(task);

    switch (newStatus) {
      case 'À Faire':
        _toDoTasks.add(task);
        break;
      case 'En Cours':
        _inProgressTasks.add(task);
        break;
      case 'Terminé':
        _completedTasks.add(task);
        break;
    }

    setState(() {}); // Rebuild the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchedProjects.getTasksForProject(widget.project.id!),
          builder:
              (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
            if (snapshot.hasData) {
              return DragDropScreen(
                tasks: snapshot.data!,
              );

              /* _toDoTasks = snapshot.data!
                  .where((task) => task.etat == 'À Faire')
                  .toList();
              _inProgressTasks = snapshot.data!
                  .where((task) => task.etat == 'En Cours')
                  .toList();
              _completedTasks = snapshot.data!
                  .where((task) => task.etat == 'Terminé')
                  .toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("To Do Tasks"),
                      cardTask(_toDoTasks),
                      dividerWidget(),
                      textWidget("In Progress Tasks"),
                      cardTask(_inProgressTasks),
                      dividerWidget(),
                      textWidget("Completed Tasks"),
                      cardTask(_completedTasks),
                    ],
                  ),
                ),
              ); */
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),

        /* ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      child: TaskWard(snapshot.data![index]),
                    );
                  },
                ) ;
              } else {
                return const CircularProgressIndicator();
              }
            }*/
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a Task'),
                content: popUp(),
                actions: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .3,
                        child: ElevatedButton(
                          onPressed: () {
                            _addTask();
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          style: Style().ElevatedButtonstyleFrom,
                          child: const Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 15,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .3,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: Style().ElevatedButtonstyleFrom,
                          child: const Text(
                            'Close',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget cardTask(tasks) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .24,
      child: ListView.builder(
        itemCount: tasks.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return DragTarget(
              onWillAcceptWithDetails: (data) => data == tasks[index],
              onAccept: (TaskModel droppedTask) {
                setState(() {});
              },
              builder: (BuildContext context, List<TaskModel?> candidateData,
                  List<dynamic> rejectedData) {
                return LongPressDraggable(
                  data: tasks[index],
                  feedback: Container(
                    height: MediaQuery.sizeOf(context).height * .26,
                    width: MediaQuery.sizeOf(context).width * .8,
                    color: CosntColor().bgTaskCardColr,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  childWhenDragging: TaskWard(tasks[index]),
                  onDragStarted: () {},
                  onDragCompleted: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: TaskWard(tasks[index]),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget feedback(name, priority, description) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: CosntColor().bgTaskCardColr,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
              trailing: priority == '0'
                  ? Text("LOW", style: Style().priorityLOWStyle)
                  : priority == '1'
                      ? Text("MEDIUM", style: Style().priorityMEDIUMStyle)
                      : Text("HIGH", style: Style().priorityHIGHStyle),
            ),
            ListTile(
              leading: Text(
                description,
                style: Style().inputStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textWidget(text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(text),
    );
  }

  Widget dividerWidget() {
    return const Divider(
      color: Colors.black54,
      height: 1,
    );
  }

  Widget popUp() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            cursorColor: Colors.blueGrey,
            decoration: InputDecoration(
              labelText: 'Task Name',
              labelStyle: Style().inputStyle,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            ),
          ),
          TextField(
            controller: _descriptionController,
            cursorColor: Colors.blueGrey,
            decoration: InputDecoration(
              labelText: 'Task Description',
              labelStyle: Style().inputStyle,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Periority',
              labelStyle: Style().inputStyle,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            ),
            value: selectedPriority,
            onChanged: (String? newValue) {
              setState(() {
                selectedPriority = newValue!;
                if (selectedPriority == 'LOW') {
                  _priorityController.text = '0';
                } else if (selectedPriority == 'MEDIUM') {
                  _priorityController.text = '1';
                } else if (selectedPriority == 'HIGH') {
                  _priorityController.text = '2';
                }
              });
            },
            items: priorities.map((String priority) {
              return DropdownMenuItem<String>(
                value: priority,
                child: Text(priority),
              );
            }).toList(),
          ),
          TextField(
            readOnly: true,
            textInputAction: TextInputAction.none,
            controller: _duDateController,
            decoration: const InputDecoration(
              labelText: 'Due Date',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            ),
            onTap: () async {
              {
                final DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050));
                if (dateTime != null) {
                  setState(() {
                    selectedDate = dateTime;
                    _duDateController.text =
                        DateFormat("yyyy-MM-dd").format(selectedDate);
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
