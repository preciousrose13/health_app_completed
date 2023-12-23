import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:health/Resources/AppColors/app_colors.dart';

class MyDrawer extends StatefulWidget {
  void Function()? ontap;
  MyDrawer({
    Key? key,
    this.ontap,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.purple,
            ),
            child: Center(
              child: Text(
                "Harees".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Your Account".tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings".tr),
            onTap: () {},
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout".tr),
              onTap: widget.ontap),
        ],
      ),
    );
  }
}
