import 'package:get/get.dart';

import '../data_source/api_service.dart';
import '../model.dart';

class UserController extends GetxController {
  final ProfileDataSourceImpl profileDataSourceImpl = ProfileDataSourceImpl();
  var isLoading = true.obs;
  var errorMessage;

  var userResponse = UserResponse(
    success: false,
    user: User(
      id: 0,
      employeeId: '',
      name: '',
      email: '',
      role: 0,
      status: 0,
      createdAt: '',
      firstName: '',
      lastName: '',
      department: '',
      designation: '',
      reportingTo: '',
      headQuarter: '',
      region: '',
      joiningDate: '',
      employeer: '',
      employeeBloodGroup: '',
      exitStatus: 0,
    ),
    message: '',
  ).obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    try {
      isLoading.value = true;
      final result = await profileDataSourceImpl.fetchprofile();
      result.fold((failure) {
        isLoading.value = false;
        errorMessage.value = 'Error: ${failure.message}';
      },
          (responseData) {
            userResponse.value = responseData;
        print('Duty data successfully fetched in controller');
        errorMessage.value = '';
        isLoading.value = false;
          },
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'An error occured: $e';
    }
  }
}

// import 'package:get/get.dart';
// import 'package:aquachemicals/features/homeScreen/presentation/settings/data_source/api_service.dart';
//
// class ProfileController extends GetxController {
//   final ProfileDataSourceImpl profileDataSourceImpl = ProfileDataSourceImpl();
//   var errorMessage = ''.obs;
//   var isLoading = false.obs;
//   var profiledata = {}.obs;
//
//
//
//   @override
//   Future<void> getprofilelist() async {
//     print('Fetching duty list data');
//     try {
//       isLoading.value = true;
//       final result = await profileDataSourceImpl.fetchprofile();
//       result.fold((failure) {
//         isLoading.value = false;
//         errorMessage.value = 'Error: ${failure.message}';
//       },
//           (responseData) {
//         profiledata.value = responseData;
//         print('Duty data successfully fetched in controller');
//         errorMessage.value = '';
//         isLoading.value = false;
//           },
//       );
//     } catch (e) {
//       isLoading.value = false;
//       errorMessage.value = 'An error occured: $e';
//     }
//   }
// }
