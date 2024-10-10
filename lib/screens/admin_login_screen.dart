import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior/app_router.dart';
import 'package:senior/services/user_service.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService(); // บริการดึงข้อมูลผู้ใช้

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('กรุณากรอกชื่อผู้ใช้และรหัสผ่าน'),
      ));
      return;
    }

    try {
      // ตรวจสอบบทบาทของผู้ใช้จาก UserService (ถ้าจำเป็น)
      var userData = await _userService.getUserData(username);
      if (userData != null && userData['role'] == 'admin') {
        // ถ้าผู้ใช้เป็น admin ให้ไปที่หน้า admin dashboard
        Navigator.pushNamed(context, AppRouter.adminDashboard);
      } else {
        // ถ้าผู้ใช้ไม่ใช่ admin
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('คุณไม่มีสิทธิ์เข้าถึง'),
        ));
      }
    } on FirebaseAuthException catch (e) {
      // จัดการกรณีที่มีปัญหาในการเข้าสู่ระบบ
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('ไม่มีผู้ใช้ดังกล่าวในระบบ'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('รหัสผ่านไม่ถูกต้อง'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('การเข้าสู่ระบบล้มเหลว: ${e.message}'),
        ));
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'ชื่อผู้ใช้ (อีเมล)'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'รหัสผ่าน'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('เข้าสู่ระบบ'),
            ),
          ],
        ),
      ),
    );
  }
}
