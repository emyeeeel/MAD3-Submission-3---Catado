import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {

  static const String route = '/home';
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return const CupertinoPageScaffold(
      child: Center(child: Text("Home"),)
    );
  }
}