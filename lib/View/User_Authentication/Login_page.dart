// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/Resources/Button/mybutton.dart';
import 'package:health/Resources/TextField/MyTextField.dart';
import 'package:health/Resources/Utils/utils.dart';
import 'package:health/Video_Call/joincall.dart';
import 'package:health/View/User_Authentication/register_page.dart';
import 'package:health/View/User_Pages/Home_page/home_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

                    //     .then((value) {
                    //   Utils().toastMessage(value.user!.email.toString());
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => HomePage()));


                    // })

                    .then((value) {
                      Utils().toastMessage(value.user!.email.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinCall(userEmail: value.user!.email.toString()),
                        ),
                      );
                    })
                    
                    .onError((error, stackTrace) {
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
                  "Not a member?".tr,
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
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
