import 'package:flutter/material.dart';
import 'package:health/Resources/AppBar/app_bar.dart';
import 'package:health/Video_Call/call.dart';

class JoinCall extends StatelessWidget {
  final String userEmail;

  const JoinCall({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCall(callID: "1")));

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MyCall(callID: "1", userEmail: userEmail),
              //   ),
              // );
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCall(callID: "1", userEmail: userEmail)));
            }, 
            child: Text('Join Call'),)
        ]
      ),
    );
  }
}