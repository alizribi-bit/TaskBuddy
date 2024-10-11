import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Setting/Langues/translationSetting.dart';
import 'Setting/Routes.dart';
import 'Views/Auth/LoginScreen.dart';
import 'Views/Home/Pages/HomePageScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('uid');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: uid == "" ? LoginScreen() : HomePageScreen(),
      getPages: AppPage.routes,
      translations: Translation(),
      locale: GetStorage().read('lang') == 'ar'
          ? const Locale('ar')
          : GetStorage().read('lang') == 'en'
              ? const Locale('en')
              : const Locale('fr'),
      fallbackLocale: GetStorage().read('lang') == 'ar'
          ? const Locale('ar')
          : GetStorage().read('lang') == 'en'
              ? const Locale('en')
              : const Locale('fr'),
    ),
  );
}

/* 
#7BD8BD green1

#9FA8DA background
#18193F fra
 */