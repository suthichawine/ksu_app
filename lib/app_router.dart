import 'package:flutter/material.dart';
import 'package:senior/components/buttoms_nav.dart';
import 'package:senior/screens/admin_dashboard_screen.dart';
import 'package:senior/screens/admin_login_screen.dart';
import 'package:senior/screens/dapartment_screen.dart';
import 'package:senior/screens/faculty_screen.dart';
import 'package:senior/screens/home_screen.dart';
import 'package:senior/screens/university_screen.dart';
import 'package:senior/screens/welcome_screen.dart';

class AppRouter {
  // Router Map Key
  static const String welcome = 'welcome';
  static const String university = 'university';
  static const String faculty = 'faculty';
  static const String department = 'department';
  static const String course = 'course';
  static const String home = 'home';
  static const String bottomsNav = 'bottomsNav';
  static const String adminLogin = 'admin_login'; // เพิ่มเส้นทางสำหรับ admin login
  static const String adminDashboard = 'admin_dashboard'; // เส้นทางสำหรับ Admin Dashboard


  // Router Map
  static Map<String, WidgetBuilder> get routes => {
        welcome: (context) => WelcomeScreen(),
        university: (context) => UniversityScreen(),
        home: (context) => const HomeScreen(),
        bottomsNav: (context) => const BottomsNav(),
        faculty: (context) => FacultyScreen(),
        department: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return DepartmentScreen(message: args);
        },
        adminLogin: (context) => AdminLoginScreen(), // กำหนดเส้นทางสำหรับ admin login
        adminDashboard: (context) => AdminDashboardScreen(), // กำหนดเส้นทางสำหรับ Admin Dashboard

      };
}
