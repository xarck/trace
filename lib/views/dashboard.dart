import 'package:flutter/material.dart';
import 'package:trace/utils/dimension.dart';
import 'package:trace/utils/util.dart';
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
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Top',
              icon: Icon(Icons.trending_up_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
          backgroundColor: hexToColor("2C3639"),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: 20.0,
          selectedFontSize: 14.0,
          selectedItemColor: Colors.green,
          unselectedFontSize: 14.0,
        ),
      ),
    );
  }
}
