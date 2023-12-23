// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/Resources/Button/mybutton.dart';
import 'package:health/Resources/TextField/MyTextField.dart';
import 'package:health/Resources/Utils/utils.dart';
import 'package:health/View/Designation%20Registration/designation.dart';
import 'package:health/View/Service%20Provider/Provider_home/service_provider_home.dart';

class Provider_login extends StatefulWidget {
  Provider_login({
    Key? key,
  }) : super(key: key);

  @override
  State<Provider_login> createState() => _Provider_loginState();
}

class _Provider_loginState extends State<Provider_login> {
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
                text: "Login".tr,
                onTap: () {
                  if (_FormKey.currentState!.validate()) {
                    _auth
                        .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) {
                      Utils().toastMessage(value.user!.email.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Service_Provider_Home()));
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  }
                }),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "Not a provider?".tr,
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Designation()));
                    },
                    child: Text("Register Now".tr,
                        style: TextStyle(fontSize: 20)))
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
