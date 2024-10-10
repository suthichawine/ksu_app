import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior/models/department_model.dart';

class DepartmentService {
  final CollectionReference department =
      FirebaseFirestore.instance.collection('department');

  Future<void> create(String facultyId, String departmentName)  {
    return department.add({
      "faculty_id": facultyId,
      "department_name": departmentName,
    });
  //   QuerySnapshot querySnapshot =
  //      await department.where('faculty_id', isEqualTo: facultyId).get();
  //    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //   await doc.reference.delete();
  // }
  //   return;
  }

  Future<List<Department>> getDepartment(String facultyId) async {
    QuerySnapshot querySnapshot =
        await department.where('faculty_id', isEqualTo: facultyId).get();
    List<Department> departments = querySnapshot.docs.map((doc) {
      return Department(
        id: doc.id,
        departmentName: doc["department_name"],
        facultyId: doc["faculty_id"],
      );
    }).toList();
    return departments;
  }
}