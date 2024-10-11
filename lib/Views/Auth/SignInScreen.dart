import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth/SigninController.dart';
import '../Widget/InputFildeWidget.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  SignInController _signInController = SignInController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _signInController.formKey,
                  child: Column(
                    children: [
                      Text(
                        "Register".tr,
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
                          _signInController.nameController,
                          TextInputType.text,
                          'Name'.tr,
                          Icons.person,
                          _signInController.nameController.text,
                          _signInController,
                          _signInController.validName,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textFormFieldWidget(
                            context,
                            _signInController.emailController,
                            TextInputType.emailAddress,
                            'Email'.tr,
                            Icons.email,
                            _signInController.emailController.text,
                            _signInController,
                            _signInController.validEmail),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textFormFieldWidget(
                            context,
                            _signInController.passwordController,
                            TextInputType.text,
                            'Password'.tr,
                            Icons.lock,
                            _signInController.passwordController.text,
                            _signInController,
                            _signInController.validPassword),
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
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'CormorantGaramond'),
                            ),
                            child: _signInController.isLoading.value
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
                                      () => _signInController.isLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Register'.tr,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                            onPressed: () {
                              _signInController.registration();
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
                            "haveaccount".tr,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed('/login');
                            },
                            child: Text(
                              "Login".tr,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
