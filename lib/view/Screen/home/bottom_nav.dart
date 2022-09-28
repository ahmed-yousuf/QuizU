import 'package:flutter/material.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/view/Screen/home/home_screen.dart';
import 'package:quizu/view/Screen/leaderboard/leaderboard_screen.dart';
import 'package:quizu/view/Screen/profile/profile_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _wedgitOption = <Widget>[
    HomeScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _wedgitOption[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        currentIndex: _selectedIndex,
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
