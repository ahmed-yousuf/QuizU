import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/view/Screen/home/home_screen.dart';
import 'package:quizu/view/Screen/leaderboard/leaderboard_screen.dart';
import 'package:quizu/view/Screen/profile/profile_screen.dart';

class BottomBar extends StatefulWidget {
  int selectedIndex;
  BottomBar({required this.selectedIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static final List<Widget> _wedgitOption = <Widget>[
    HomeScreen(),
    LeaderboardScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _wedgitOption[widget.selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        currentIndex: widget.selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Image.asset(
              Images.homeIconFIll,
              color: Colors.grey,
              height: 25,
            ),
            activeIcon: Image.asset(
              Images.homeIconFIll,
              color: Theme.of(context).primaryColor,
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: "Leaderboard",
            icon: Image.asset(
              Images.leaderIconFIll,
              color: Colors.grey,
              height: 25,
            ),
            activeIcon: Image.asset(
              Images.leaderIconFIll,
              color: Theme.of(context).primaryColor,
              height: 26,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Image.asset(
              Images.profileIconFIll,
              color: Colors.grey,
              height: 25,
            ),
            activeIcon: Image.asset(
              Images.profileIconFIll,
              color: Theme.of(context).primaryColor,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
