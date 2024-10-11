import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../Models/Task.dart';
import '/../Setting/Style/Style.dart';

import '../../../../../Setting/Colors.dart';

Widget TaskWard(TaskModel task) {
  return Container(
    width: Get.width * .9,
    decoration: BoxDecoration(
      color: CosntColor().bgTaskCardColr,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: task.priority! == '0'
              ? CosntColor().priorityLOWColor.withOpacity(0.3)
              : task.priority! == '1'
                  ? CosntColor().priorityMEDIUMColor.withOpacity(0.3)
                  : CosntColor().priorityHIGHColor.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 3,
          offset: const Offset(6, 4), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              task.name ?? '',
              style: const TextStyle(fontSize: 20),
            ),
            trailing: task.priority! == '0'
                ? Text("LOW", style: Style().priorityLOWStyle)
                : task.priority! == '1'
                    ? Text("MEDIUM", style: Style().priorityMEDIUMStyle)
                    : Text("HIGH", style: Style().priorityHIGHStyle),
          ),
          ListTile(
            leading: Text(
              task.description ?? '',
              style: Style().inputStyle,
            ),
          ),
        ],
      ),
    ),
  );
}
