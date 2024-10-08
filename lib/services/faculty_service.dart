class Faculty {
  final String id;
  final String faculty_name;
  final String image;

  Faculty({
    required this.id,
    required this.faculty_name,
    required this.image,
  });
}

class FacultyService {
  // ตัวอย่างข้อมูลที่จำลอง
  final List<Faculty> mockFaculties = [
    Faculty(
      id: '1',
      faculty_name: 'Faculty of Engineering',
      image: 'assets/images/faculty_of_engineering.jpg',
    ),
    Faculty(
      id: '2',
      faculty_name: 'Faculty of Science',
      image: 'assets/images/faculty_of_science.jpg',
    ),
    Faculty(
      id: '3',
      faculty_name: 'Faculty of Arts',
      image: 'assets/images/faculty_of_arts.jpg',
    ),
  ];

  Future<List<Faculty>> getAllFaculties() async {
    try {
      // ใช้ข้อมูลจำลองแทนการดึงข้อมูลจาก Firebase
      await Future.delayed(Duration(seconds: 1)); // จำลองการหน่วงเวลา
      return mockFaculties;
    } catch (e) {
      print("Error getting faculties: $e");
      return [];
    }
  }
}
