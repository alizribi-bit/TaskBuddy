import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../Controllers/Auth/LoginController.dart';

import '../Widget/InputFildeWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.put(AuthController());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login".tr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textFormFieldWidget(
                        context,
                        _authController.emailController,
                        TextInputType.emailAddress,
                        'Email'.tr,
                        Icons.email,
                        _authController.emailController.text,
                        _authController,
                        _authController.validEmail),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textFormFieldWidget(
                        context,
                        _authController.passwordController,
                        TextInputType.text,
                        'Password'.tr,
                        Icons.email,
                        _authController.passwordController.text,
                        _authController,
                        _authController.validPassword),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width * .8,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'CormorantGaramond',
                          ),
                        ),
                        child: _authController.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : FittedBox(
                                child: Obx(
                                  () => _authController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'Login'.tr,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                        onPressed: () {
                          _authController.login();
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Donthaveaccount".tr,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offNamed('/register');
                        },
                        child: Text(
                          "Register".tr,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
