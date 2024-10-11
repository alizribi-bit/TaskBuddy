import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Services/Projects/ProjectServices.dart';
import '../../Models/Project.dart';
import '../../Setting/Style/Style.dart';

Widget projectWidget(Project project, Function onDelete) {
  ProjectManager fetchedProjects = ProjectManager();
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      elevation: 12,
      shadowColor: Colors.pink,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              project.image == ""
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        project.image!,
                        width: Get.width * .9,
                        height: Get.height * .3,
                        fit: BoxFit.fill,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: Get.width * .6,
                    height: Get.height * .05,
                    child: Stack(
                      children: [
                        //CardAppointmentWidget(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(project.name!,
                              style: Style().projectNameStyle),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              project.description!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              project.duDate!.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
              leading: Column(
                children: [
                  Text(
                    "${project.tasks!.length} Tesk's",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${project.notes!.length} Note's",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              trailing: TextButton(
                child: Text(
                  "Delete",
                  style: Style().DeleteStyle,
                ),
                onPressed: () {
                  fetchedProjects.deleteProject(project.id!);
                  onDelete();
                },
              )
              /* IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: CosntColor().delete,
                size: 32,
              ),
            ), */
              ),
        ],
      ),
    ),
  );
}
