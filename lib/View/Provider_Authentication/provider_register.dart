// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:health/Resources/Button/mybutton.dart';
import 'package:health/Resources/Designation_Dropdown/dropdown.dart';
import 'package:health/Resources/TextField/MyTextField.dart';
import 'package:health/Resources/Utils/utils.dart';
import 'package:health/View/Service%20Provider/Provider_home/service_provider_home.dart';

class Designation extends StatefulWidget {
  const Designation({
    Key? key,
  }) : super(key: key);
  @override
  State<Designation> createState() => _DesignationState();
}

class _DesignationState extends State<Designation> {
  final nameControlLer = TextEditingController();

  final emailControlLer = TextEditingController();

  final designationController = TextEditingController();

  final passwordController = TextEditingController();

  final idNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          AssetImage("assets/logo/harees_logo.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "Joining as a Service Provider".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          controller: nameControlLer,
                          obscureText: false,
                          labelText: "Name".tr,
                          conditionText: "Name required".tr),
                      MyTextField(
                          controller: emailControlLer,
                          obscureText: false,
                          labelText: "email".tr,
                          conditionText: "Email required".tr),
                      MyTextField(
                          controller: passwordController,
                          obscureText: true,
                          labelText: "password".tr,
                          conditionText: "Password required".tr),
                      MyDropdown(),
                      MyTextField(
                          controller: idNumberController,
                          obscureText: false,
                          labelText: "ID CARD Number".tr,
                          conditionText: "ID Number required".tr),
                      SizedBox(
                        height: 10,
                      ),
                      RoundButton(
                          text: "Login".tr,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _auth
                                  .createUserWithEmailAndPassword(
                                      email: emailControlLer.text,
                                      password: passwordController.text)
                                  .then((value) {
                                Utils()
                                    .toastMessage(value.user!.email.toString());
                                Get.to(() => Service_Provider_Home(userEmail: value.user!.email.toString()));
                              }).onError((error, stackTrace) {
                                Utils().toastMessage(error.toString());
                              });
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
