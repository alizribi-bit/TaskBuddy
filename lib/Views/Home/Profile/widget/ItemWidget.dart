import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Setting/Colors.dart';
import '../../../../Setting/Style/Style.dart';

Container ItemWidget() {
  return Container(
    width: Get.width,
    height: Get.height * .07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: CosntColor().buttonTealColor,
    ),
    child: Center(
      child: ListTile(
        leading: Text(
          "Log Out",
          style: Style().buttonStyle,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          size: 30,
          color: Colors.blueGrey,
        ),
      ),
    ),
  );
}
