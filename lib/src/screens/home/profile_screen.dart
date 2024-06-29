import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           const SizedBox(height: 100,),
           const Text("My Profile", 
           style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold, 
                color: Colors.black, 
            ),
           ),
           const SizedBox(height: 20,),
            GestureDetector(
              onTap: () async {
                showCupertinoDialog(
                  context: context, 
                  builder: (context) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                );
                await Future.delayed(Durations.medium1);
                await FirebaseAuth.instance.signOut();
              },
              child: const SizedBox(
                child: Row(children: [
                  SizedBox(width: 20,), 
                  Icon(Icons.logout, color: Colors.red,), 
                  SizedBox(width: 15,), 
                  Text('Log out', style: TextStyle(color: Colors.red),), 
                  ],
                ),
              ),
            ),
         ],
       ),
     );
  }
}