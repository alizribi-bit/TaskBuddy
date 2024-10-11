import 'package:flutter/material.dart';

import '../../../Controllers/Auth/LogoutController.dart';
import 'widget/ItemWidget.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  LogoutController _LogoutController = LogoutController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                    onTap: () {
                      _LogoutController.signOut(context);
                    },
                    child: ItemWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
