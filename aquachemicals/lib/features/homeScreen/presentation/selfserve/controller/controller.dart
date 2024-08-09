import 'package:get/get.dart';
import 'package:aquachemicals/features/homeScreen/presentation/selfserve/model/employeleave_model.dart';
import 'package:aquachemicals/features/homeScreen/presentation/selfserve/datasource/data_source_impl.dart';

class EmployeeLeaveController extends GetxController {
  var isLoading = true.obs;
  var employeeLeaveList = EmployeeLeaveList(success: false, employeeLeaves: [], message: '').obs;

  @override
  void onInit() {
    fetchEmployeeLeaves();
    super.onInit();
  }

  void fetchEmployeeLeaves() async {
    try {
      isLoading(true);
      var employeeLeaves = await ApiService().fetchEmployeeLeaves();
      employeeLeaveList.value = employeeLeaves;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
