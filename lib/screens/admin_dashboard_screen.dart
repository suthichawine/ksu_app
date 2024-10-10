import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // ปุ่มเพิ่มประกาศ
            Card(
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text('เพิ่ม'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
            // ปุ่มแก้ไขประกาศ
            Card(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('แก้ไข'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
            // ปุ่มลบประกาศ
            Card(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('ลบ'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เลือกการดำเนินการ'),
          content: Text('คุณต้องการทำงานในส่วน PLO หรือ Announcement?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // ทำงานสำหรับ PLO
                _showPLOActionDialog(context);
              },
              child: Text('PLO'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // ทำงานสำหรับ Announcement
                _showAnnouncementActionDialog(context);
              },
              child: Text('Announcement'),
            ),
          ],
        );
      },
    );
  }

  void _showPLOActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PLO'),
          content: Text('นี่คือการทำงานในส่วนของ PLO'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  void _showAnnouncementActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Announcement'),
          content: Text('นี่คือการทำงานในส่วนของ Announcement'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }
}
