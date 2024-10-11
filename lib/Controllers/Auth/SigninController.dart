import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/comment.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var name = '';
  var email = '';
  var password = '';

  var isImgAvailable = false.obs;
  final _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var isLoading = false.obs;

  CollectionReference userDatBaseReference =
      FirebaseFirestore.instance.collection("user");
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
      snackMessage("No image selected");
    }
  }

  String? validName(String value) {
    if (value.length < 3) {
      return "Name must be 3 characters";
    }
    return null;
  }

  String? validEmail(String value) {
    if (!GetUtils.isEmail(value.trim())) {
      return "Please Provide Valid Email";
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  /// Registers a new user with the given email and password.
  ///
  /// Validates the form, shows a loading indicator, saves the form,
  /// calls the userRegister() method, and handles the result.
  /// Shows a snackbar message on error.
  Future<void> registration() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isLoading.value = true;
    formKey.currentState!.save();
    email = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    userRegister(email.trim(), password.toString().trim()).then((credentials) {
      if (credentials != null) {
      } else {
        snackMessage("User already exist");
      }
      isLoading.value = false;
    });
  }

  /**
   * Registers a new user with the given email and password.
   * 
   * This is an async function that returns a UserCredential if successful,
   * or null if there was an error.
   * 
   * It first calls FirebaseAuth.createUserWithEmailAndPassword() to create 
   * the user. 
   * 
   * If successful, it sends a verification email to the user, saves data to 
   * the database, logs the user out, and returns the UserCredential.
   * 
   * If there is an error creating the user, it prints the error and shows a
   * snackbar message.
   */
  /**
   * Registers a new user with the given email and password.
   * 
   * This is an async method that returns a UserCredential if successful,
   * or null if there was an error.
   * 
   * It first calls FirebaseAuth.createUserWithEmailAndPassword() to create 
   * the user. 
   * 
   * If successful, it sends a verification email to the user, saves data to
   * the database, logs the user out, and redirects to the login page.
   * 
   * If there is a FirebaseAuthException, it prints the error and displays
   * a snackbar message that the user already exists.
   * 
   * Other exceptions are printed to the console.
  */
  Future<UserCredential?> userRegister(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // if (value != null)
        User? user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification();
        snackMessage('Check your Email');
        saveDataToDb().then((value) async {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        });
        Get.offAllNamed('/login');
        return;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      snackMessage('user already exist');
    } catch (e) {
      print("** $e");
    }

    return userCredential;
  }

  /**
   * Uploads the file at the given file path to Firebase Storage 
   * with a random name.
   * 
   * Returns the download URL for the uploaded file.
  */
  Future<String?> uploadFile(filePath) async {
    File file = File(filePath);
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    try {
      await _storage.ref('uploads/user/${randomStr}').putFile(file);
    } on FirebaseException catch (e) {
      snackMessage(e.code.toString());
    }
    String downloadURL =
        await _storage.ref('uploads/user/${randomStr}').getDownloadURL();

    return downloadURL;
  }

  /// Saves the current user's data to the database.
  ///
  /// Gets the current authenticated user from Firebase Auth.
  /// Writes the user's UID, name, email, and empty url field to the
  /// document in userDatBaseReference with the UID as the ID.
  /// Returns nothing.
  Future<void> saveDataToDb() async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.doc(user!.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'url': '',
    });
    return;
  }

  /**
   * Updates the user profile with the given image URL.
   *
   * If a new image was selected, uploads it and updates profile with URL.
   * Otherwise just updates profile with given URL.
   *
   * Also updates user email if emailController changed.
   */
  void updateProfile(String argUrl) {
    User? user = FirebaseAuth.instance.currentUser;

    if (isImgAvailable == true) {
      uploadFile(selectedImagePath.value).then((url) async {
        if (url != null) {
          userDatBaseReference.doc(user!.uid).update({
            'uid': user.uid,
            'name': nameController.text,
            'email': emailController.text,
            'url': url
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', user.email.toString());
          prefs.setString('name', user.displayName.toString());
          prefs.setString('photo', user.photoURL.toString());
          prefs.setString('uid', user.uid.toString());
          prefs.setString('tokenId', user.getIdTokenResult().toString());
          prefs.setString(
              'password', passwordController.text.trim().toString());
        } else {
          snackMessage("Image not Uploaded");
        }
      });
    } else {
      userDatBaseReference.doc(user!.uid).update({
        'uid': user.uid,
        'name': nameController.text,
        'email': emailController.text,
        'url': argUrl == "" ? '' : argUrl,
      });

      user
          .updateEmail(emailController.text.toString().trim())
          .then((value) async {
        snackMessage("Updated Successfully");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email.toString());
        prefs.setString('name', user.displayName.toString());
        prefs.setString('photo', user.photoURL.toString());
        prefs.setString('uid', user.uid.toString());
        prefs.setString('tokenId', user.getIdTokenResult().toString());
        prefs.setString('password', passwordController.text.trim().toString());
      }).catchError((error) {
        snackMessage("Email not Updated");
        print(error);
      });
    }
  }
}
