import 'package:flutter/material.dart';

import 'Business_Screen.dart';
import 'Category_Screen.dart';
import 'Profile_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // bottom nav index

  final List<Widget> _page= [
    CategoryScreen(),
    BusinessScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        selectedItemColor:Colors.blue,

        elevation: 5,
        currentIndex:_selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_business_rounded),label: 'My Business'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
          ],
        onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
        },
      ),

      body: _selectedIndex == 0
          ? CategoryScreen()
          : _page[_selectedIndex],
    );
  }
}
