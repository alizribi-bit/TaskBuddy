import 'package:flutter/material.dart';

import '../../../../Controllers/Services/Projects/NoteServices.dart';
import '../../../../Models/Note.dart';
import '../../../../Models/Project.dart';
import 'Widget/NoteCardWidget.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required Project this.project});
  final Project project;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Note> note = [];
  final TextEditingController _noteController = TextEditingController();

  void _addNote() {
    String note = _noteController.text;
    if (note.isNotEmpty) {
      NoteManager().addNoteForProject(widget.project.id.toString(), note);
      // You can add navigation or feedback here after adding the project
    } else {
      // Handle validation or show error message if fields are empty
    }
  }

  NoteManager fetchedProjects = NoteManager();

/*   Future<void> _fetchNoteProjects() async {
    List<Note> fetchedProjects = await NoteManager().getNotesForProject(
      widget.project.id.toString(),
    );
    if (mounted) {
      setState(() {
        note = fetchedProjects;
      });
    }
  } */

  @override
  void initState() {
    //_fetchNoteProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: fetchedProjects.getNotesForProject(widget.project.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NoteCard(snapshot.data![index]);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add a Task'),
                content: popUp(),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _addNote();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
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

  Widget popUp() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .25,
      width: double.infinity * .9,
      child: Column(children: [
        TextField(
          controller: _noteController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
      ]),
    );
  }
}
