import 'dart:ffi';

import 'package:get/get.dart';
import 'package:aquachemicals/core/error/failure.dart';
import 'package:aquachemicals/features/homeScreen/presentation/request/datasource/request_datasource_impl.dart';

class RequestController extends GetxController {
  final RequestDataSourceImpl requestDataSourceImpl = RequestDataSourceImpl();
  var errorMessage1 = ''.obs;
  var errorMessage2 = ''.obs;
  var errorMessage3 = ''.obs;
var typesave = ''.obs;
  var isLoading = false.obs;
  var dutydata = {}.obs;
  var leavedata = {}.obs;
  var vacationdata = {}.obs;
  @override

  void initState() {
    getdutylist(typesave.value);
    getleavelist(typesave.value);
    getvactionlist(typesave.value);
  }


  @override
  Future<void> getdutylist(String type) async {
    print('Fetching duty list data');
    typesave.value = type;
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

  Future<void> getleavelist(String type) async {
    print('Fetching leave list data');
    print(type);
     try {
      isLoading.value = true;
      final result = await requestDataSourceImpl.fetchleave(type);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage2.value = 'Error: ${failure.message}';
        },
            (responseData) {
          leavedata.value = responseData;
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

  Future<void> getvactionlist(String type) async {
    print('Fetching vacation list data');
    try {
      isLoading.value = true;
      final result = await requestDataSourceImpl.fetchvaction(type);
      result.fold(
            (failure) {
          isLoading.value = false;
          errorMessage3.value = 'Error: ${failure.message}';
        },
            (responseData) {
          vacationdata.value = responseData;
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
