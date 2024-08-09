
import 'package:get/get.dart';
import 'package:aquachemicals/core/error/failure.dart';
import 'package:aquachemicals/features/homeScreen/presentation/teamleaves/datasource/teamleaves_datasource.dart';

class TeamLeavesController extends GetxController {
  final TeamleavesDataSourceImpl teamleavesDataSourceImpl = TeamleavesDataSourceImpl();
  var errorMessage1 = ''.obs;
  var errorMessage2 = ''.obs;
  var errorMessage3 = ''.obs;
 // var typesave = ''.obs;
  var isLoading = false.obs;
  var dutyfilterdata = {}.obs;
  var leavefilterdata = {}.obs;
  var vacationfilterdata = {}.obs;



  @override
  Future<void> getdutylist(String type,String filter) async {
print('$type,$filter,jjhggygyggyugy');
    try {
      isLoading.value = true;
      final result = await teamleavesDataSourceImpl.fetchdutyfilter(type,filter);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage1.value = 'Error: ${failure.message}';
        },
            (responseData) {
          dutyfilterdata.value = responseData;
          print('Duty filter data successfully fetched in controller');
          errorMessage1.value = '';
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage1.value = 'An error occurred: $e';
    }
  }

  Future<void> getleavelist(String type,String filter) async {
    print('Fetching leave filter data');
    print('$type,jjhggygyggyugy');

    print(type);
    try {
      isLoading.value = true;
      final result = await teamleavesDataSourceImpl.fetchleavefilter(type,filter);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage2.value = 'Error: ${failure.message}';
        },
            (responseData) {
          leavefilterdata.value = responseData;
          print('Leave data successfully fetched in controller');
          errorMessage2.value = '';
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage2.value = 'An error occurred: $e';
    }
  }

  Future<void> getvactionlist(String type,String filter) async {
    print('Fetching vacation list data');
    print('$type,jjhggygyggyugy');

    try {
      isLoading.value = true;
      final result = await teamleavesDataSourceImpl.fetchvactionfilter(type,filter);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage3.value = 'Error: ${failure.message}';
        },
            (responseData) {
          vacationfilterdata.value = responseData;
          print('Vacation data successfully fetched in controller');
          errorMessage3.value = '';
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage3.value = 'An error occurred: $e';
    }
  }
}
