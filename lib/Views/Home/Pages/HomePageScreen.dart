import 'package:flutter/material.dart';

import '../../Luncher/SeplashScreenHome.dart';
import '../Habbits/HabbitScreen.dart';
import '../Profile/ProfileScreen.dart';
import '../Tasks/TaskNoteScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentPage = 0;
  //final _pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> _ScreenList = [
    const HomeSeplashScreen(),
    const HabbitScreen(),
    const TaskNoteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ScreenList[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: _currentPage == 0
                ? Image.asset(
                    'assets/projectgreen.png',
                    width: 24,
                    height: 24,
                  )
                : Image.asset(
                    'assets/project1.png',
                    width: 24,
                    height: 24,
                  ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: _currentPage == 1
                ? Image.asset(
                    'assets/habitgreen.png',
                    width: 24,
                    height: 24,
                  )
                : Image.asset(
                    'assets/habit.png',
                    width: 24,
                    height: 24,
                  ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: _currentPage == 2
                ? Image.asset(
                    'assets/checkgreen.png',
                    width: 24,
                    height: 24,
                  )
                : Image.asset(
                    'assets/check.png',
                    width: 24,
                    height: 24,
                  ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: _currentPage == 3
                ? Image.asset(
                    'assets/profilegreen.png',
                    width: 24,
                    height: 24,
                  )
                : Image.asset(
                    'assets/prifile.png',
                    width: 24,
                    height: 24,
                  ),
          ),
        ],
        onTap: _onItemTapped,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
