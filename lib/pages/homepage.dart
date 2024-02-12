import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/calenderpage.dart';
import 'package:flutter_tim/pages/stastic.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Placeholder(), 
    const stastic(),
    const ScreenCalendar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          color: const Color.fromARGB(255, 62, 78, 47),
          activeColor: const Color.fromARGB(255, 62, 78, 47),
          tabBackgroundColor: const Color.fromARGB(255, 206, 222, 189),
          gap: 8,
          padding: const EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.insert_chart_outlined_outlined,
              text: 'Statistic',
            ),
            GButton(
              icon: Icons.calendar_view_day_rounded,
              text: 'Calendar',
            ),
          ],
        ),
      ),
    );
  }
}
