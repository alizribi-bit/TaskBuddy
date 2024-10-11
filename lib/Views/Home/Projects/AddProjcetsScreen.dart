import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controllers/Services/Projects/ProjectServices.dart';
import '../../../Setting/Style/Style.dart';
import '../Pages/HomePageScreen.dart';

class AddProjectsScreen extends StatefulWidget {
  const AddProjectsScreen({super.key});

  @override
  State<AddProjectsScreen> createState() => _AddProjectsScreenState();
}

class _AddProjectsScreenState extends State<AddProjectsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _duDateController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();

  void _addProject() {
    String name = _nameController.text;
    String description = _descriptionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      ProjectManager()
          .addProject(name, description, _image, _duDateController.text);
      // You can add navigation or feedback here after adding the project
    } else {
      // Handle validation or show error message if fields are empty
    }
  }

  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('photo', _image!.path.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Get.to(HomePageScreen());
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        _openImagePicker();
                        setState(() {});
                      },
                      child: _image != null
                          ? Container(
                              width: MediaQuery.sizeOf(context).width * .5,
                              height: MediaQuery.sizeOf(context).height * .2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    _image!,
                                  ),
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/image.jpg',
                              width: MediaQuery.sizeOf(context).width * .5,
                              height: MediaQuery.sizeOf(context).height * .2,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: _nameController,
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: Style().inputStyle,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: Style().inputStyle,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      readOnly: true,
                      textInputAction: TextInputAction.none,
                      controller: _duDateController,
                      decoration: const InputDecoration(
                        labelText: 'Due Date',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 16.0),
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
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addProject,
                      style: Style().ElevatedButtonstyleFrom,
                      child: Text(
                        'Add Project',
                        style: Style().buttonStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
