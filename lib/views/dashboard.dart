import 'package:flutter/material.dart';
import 'package:trace/utils/dimension.dart';
import 'package:trace/views/chart_view.dart';
import 'package:trace/views/home_view.dart';
import 'package:trace/views/library_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Home(),
    Chart(),
    Library(),
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
            label: 'Chart',
            icon: Icon(Icons.charging_station),
          ),
          BottomNavigationBarItem(
            label: 'Library',
            icon: Icon(Icons.bookmark),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
