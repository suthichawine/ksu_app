import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Index 1 for University

  final List<String> _titles = [
    "Home",
    "University",
    "Faculty",
    "Course",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ksu1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Text(
              'Welcome to University Screen',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
