import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:senior/app_router.dart';
import 'package:senior/models/announcement_model.dart';
import 'package:senior/services/firestore_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/ksu3.jpg',
      'assets/images/ksu1.jpg',
      'assets/images/ksu2.jpg',
      'assets/images/ksu7.jpg',
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("ksu"),
          actions: [
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () {
                Get.toNamed(AppRouter.adminLogin); // ใช้เส้นทางจาก AppRouter
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            // เนื้อหา HomeScreen ทั้งหมด
            Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Images(imagePaths), // ส่วนของรูปภาพ
                        const SizedBox(height: 20),
                        StreamBuilder<List<Announcement>>(
                          stream: firestoreService.getAnnouncements(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return const Text('Error loading announcements');
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No announcements available');
                            }

                            return Announcements((snapshot.data!..shuffle())
                                .take(3)
                                .toList()); // แสดง 3 ประกาศ
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  // Widget to display announcements in card style
  Widget Announcements(List<Announcement> announcements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            "Announcements",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap:
              true, // Allows ListView to be inside SingleChildScrollView
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      announcement.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      announcement.content,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget to display images in horizontal scroll view
  Widget Images(List<String> imagePaths) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: imagePaths.map((path) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 250,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
