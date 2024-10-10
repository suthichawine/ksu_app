import 'dart:convert';

Department departmentFromJson(String str) => Department.fromJson(json.decode(str));

String departmentToJson(Department data) => json.encode(data.toJson());

class Department {
    String id;
    String departmentName;
    String facultyId;

    Department({
        required this.id,
        required this.departmentName,
        required this.facultyId,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["department_name"],
        facultyId: json["faculty_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "faculty_id": facultyId,
    };
}