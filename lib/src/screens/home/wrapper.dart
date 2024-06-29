import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../routing/router.dart';
import 'home_screen.dart';
import 'profile_screen.dart';


class HomeWrapper extends StatefulWidget {
  final Widget? child;
  const HomeWrapper({super.key, this.child});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int index = 0;

  List<String> routes = [HomeScreen.route, ProfileScreen.route];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            GlobalRouter.I.router.go(routes[i]);
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        Widget? selectedScreen;
        switch (index) {
          case 0:
            selectedScreen = const HomeScreen();
            break;
          case 1:
            selectedScreen = const ProfileScreen();
            break;
          default:
            selectedScreen = Container();
        }
        return CupertinoTabView(builder: (BuildContext context) => selectedScreen!);
      },
    );
  }
}