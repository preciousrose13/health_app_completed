// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/Resources/Button/mybutton.dart';
import 'package:health/Resources/TextField/MyTextField.dart';
import 'package:health/Resources/Utils/utils.dart';
import 'package:health/View/User_Authentication/Login_page.dart';
import 'package:health/View/User_Pages/Home_page/home_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/logo/harees_logo.png"))),
            const SizedBox(
              height: 40,
            ),
            Form(
                key: _FormKey,
                child: Column(children: [
                  MyTextField(
                      controller: emailController,
                      obscureText: false,
                      labelText: "Email".tr,
                      conditionText: "Email cannot be empty".tr),
                  MyTextField(
                      controller: passwordController,
                      obscureText: true,
                      labelText: "Password".tr,
                      conditionText: "Password cannot be empty".tr),
                ])),
            const SizedBox(height: 50),
            RoundButton(
                text: "Register".tr,
                onTap: () async {
                  if (_FormKey.currentState!.validate()) {
                    try {
                      await _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // User creation was successful, navigate to the home page or show a success message.
                      Utils().toastMessage("Account created successfully".tr);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } on FirebaseAuthException catch (e) {
                      // Handle FirebaseAuthException
                      if (e.code == 'email-already-in-use') {
                        Get.snackbar("Error".tr,
                            "The email address is already in use by another account.".tr);
                      } else if (e.code == 'weak-password') {
                        Get.snackbar(
                            "Error", "The password provided is too weak.".tr);
                      } else {
                        Get.snackbar(
                            "Error".tr,
                            e.message ??
                                "An error occurred while creating the account.".tr);
                      }
                    } catch (e) {
                      // Handle other exceptions
                      Get.snackbar("Error".tr, e.toString());
                    }
                  }
                }),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "Already a member?".tr,
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("Let's login".tr,
                        style: TextStyle(fontSize: 20)))
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
