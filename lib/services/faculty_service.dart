import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior/models/faculty_model.dart';

class FacultyService {
  final CollectionReference faculty =
      FirebaseFirestore.instance.collection('faculty');

 

  Future<List<Faculty>> getAllFaculties() async {
    try {
      QuerySnapshot querySnapshot = await faculty.get();
      List<Faculty> faculties = querySnapshot.docs.map((doc) {
        return Faculty(
          id: doc.id,
          faculty_name: doc["faculty_name"],
          image: doc["image"],
        );
      }).toList();
      return faculties;
    } catch (e) {
      print("Error getting faculties: $e");
      return [];
    }
  }
}

