import 'package:get/get.dart';
import 'package:aquachemicals/core/error/failure.dart';
import 'package:aquachemicals/features/homeScreen/presentation/request/datasource/request_datasource_impl.dart';

class PostRequestController extends GetxController {
  final RequestDataSourceImpl requestDataSourceImpl = RequestDataSourceImpl();
  var errorMessage1 = ''.obs;
  var errorMessage2 = ''.obs;
  var errorMessage3 = ''.obs;

  var isLoading = false.obs;
  var dutydata = {}.obs;
  var leavedata = {}.obs;
  var vacationdata = {}.obs;

  @override
  Future<void> PostDutyStatus(String type) async {
    print('Fetching duty list data');
    print(type);
    try {
      isLoading.value = true;
      final result = await requestDataSourceImpl.fetchduty(type);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage1.value = 'Error: ${failure.message}';
        },
            (responseData) {
          dutydata.value = responseData;
          print('Duty data successfully fetched in controller');
          errorMessage1.value = '';
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage1.value = 'An error occurred: $e';
    }
  }
}