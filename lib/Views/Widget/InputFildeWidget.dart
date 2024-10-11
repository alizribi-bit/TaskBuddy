import 'package:flutter/material.dart';

TextFormField textFormFieldWidget(context, controller, type, labele, icon,
    controllerValue, userController, validator) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onSaved: (value) {
      controllerValue = value!;
    },
    validator: (value) {
      return validator(value!);
    },
    decoration: DecorationWidget(context, labele, icon),
    cursorColor: Colors.black,
  );
}

InputDecoration DecorationWidget(BuildContext context, String text, icon) {
  return InputDecoration(
    fillColor: Colors.grey.shade200,
    filled: true,
    prefixIcon: Padding(
      padding: const EdgeInsets.fromLTRB(15, 13, 3, 13),
      child: Icon(
        icon,
        size: 20,
        color: Colors.grey,
      ),
    ),
    label: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade400),
      ),
    ),
    contentPadding: EdgeInsets.zero,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal.shade600),
      gapPadding: 1.0,
      borderRadius: BorderRadius.circular(14),
    ),
  );
}
