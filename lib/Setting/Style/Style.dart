import 'package:flutter/material.dart';

import '../Colors.dart';

class Style {
  TextStyle inputStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.blueGrey,
  );

  TextStyle buttonStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  TextStyle projectNameStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 2);

  TextStyle priorityLOWStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CosntColor().priorityLOWColor,
      letterSpacing: 1);

  TextStyle priorityMEDIUMStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CosntColor().priorityMEDIUMColor,
      letterSpacing: 1);

  TextStyle priorityHIGHStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CosntColor().priorityHIGHColor,
      letterSpacing: 1);

  var ElevatedButtonstyleFrom = ElevatedButton.styleFrom(
    backgroundColor: Colors.teal.shade50,
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 3,
  );

  TextStyle DeleteStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CosntColor().delete,
      letterSpacing: 1);
}
