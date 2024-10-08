
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:senior/services/faculty_service.dart';

class FacultyController extends GetxController {
  var faculties = <Faculty>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaculties();
  }

  Future<void> fetchFaculties() async {
    try {
      isLoading(true);
      // await Future.delayed(const Duration(seconds: 3));
      var fetchedFaculties = await FacultyService().getAllFaculties();
      faculties.assignAll(fetchedFaculties);
    } finally {
      isLoading(false);
    }
  }
}