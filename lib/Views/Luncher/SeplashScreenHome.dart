import 'package:flutter/material.dart';

import '../Home/Projects/GetProjectsScreens.dart';

class HomeSeplashScreen extends StatefulWidget {
  const HomeSeplashScreen({super.key});

  @override
  State<HomeSeplashScreen> createState() => _HomeSeplashScreenState();
}

class _HomeSeplashScreenState extends State<HomeSeplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetProjectsScreen();
  }
}

//import 'package:shared_preferences/shared_preferences.dart';
//import '../../Models/User.dart';
 /* Future<User> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? image = prefs.getString('photo');
    String? uid = prefs.getString('uid');

    return User(
      name: name,
      email: email,
      password: password,
      image: image,
      uid: uid,
    );
  }
 FutureBuilder<User>(
          future: _getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    snapshot.data!.image != ""
                        ? Image.asset('${snapshot.data!.image!}')
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    snapshot.data!.name != ""
                        ? Text(
                            snapshot.data!.name!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.email!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.password!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.uid!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ), */
