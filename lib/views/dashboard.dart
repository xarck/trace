import 'package:flutter/material.dart';
import 'package:trace/utils/dimension.dart';
<<<<<<< HEAD
import 'package:trace/views/history_view.dart';
import 'package:trace/views/home_view.dart';
=======
import 'package:trace/views/home_view.dart';
import 'package:trace/views/library_view.dart';
>>>>>>> building
import 'package:trace/views/profile_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
<<<<<<< HEAD
    HomeView(),
    HistoryView(),
    ProfileView(),
=======
    Home(),
    Library(),
    Profile(),
>>>>>>> building
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
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
<<<<<<< HEAD
            label: 'History',
            icon: Icon(Icons.charging_station),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.bookmark),
=======
            label: 'Library',
            icon: Icon(Icons.trending_up_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
>>>>>>> building
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
