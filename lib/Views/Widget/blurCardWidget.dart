import 'dart:ui';

import 'package:flutter/material.dart';

Widget CardAppointmentWidget() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(24),
    child: Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 25,
              sigmaY: 25,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(.13),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white30, Colors.white54],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 25,
                      spreadRadius: -2),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
