import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/Services/Projects/ProjectServices.dart';
import '../../Widget/ProjectWidget.dart';
import 'ProjcetScreen.dart';

class GetProjectsScreen extends StatefulWidget {
  const GetProjectsScreen({super.key});

  @override
  State<GetProjectsScreen> createState() => _GetProjectsScreenState();
}

class _GetProjectsScreenState extends State<GetProjectsScreen> {
  @override
  void initState() {
    super.initState();
  }

  ProjectManager fetchedProjects = ProjectManager();

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
              future: fetchedProjects.getProjects(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectScreen(
                                    project: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            child: projectWidget(
                              snapshot.data![index],
                              () {
                                setState(() {});
                              },
                            )),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.offAllNamed("/addProject");
          },
        ),
      ),
    );
  }
}
