import 'package:flutter/material.dart';
import 'package:trace/utils/dimension.dart';
import 'package:trace/views/home_view.dart';
import 'package:trace/views/library_view.dart';
import 'package:trace/views/profile_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Home(),
    Library(),
    Profile(),
  ];
  _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: getSize(context).height,
        width: getSize(context).width,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Library',
            icon: Icon(Icons.trending_up_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 26.0,
        selectedFontSize: 16.0,
        selectedItemColor: Colors.green,
        unselectedFontSize: 16.0,
      ),
    );
  }
}
