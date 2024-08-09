import 'package:aquachemicals/login/presentation/login-Reg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aquachemicals/features/auth_service/auth_service.dart';
import 'package:aquachemicals/login/presentation/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';


class LoginController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  var otpVisibility = false.obs;
  var isPasswordVisible = true.obs;
  var Password = "".obs;
  var isLoading = false.obs;
  var isLogin = false.obs;
  var UserName = "".obs;
  var Id = "";
var id1 = 0;
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    loadLoginState();
  }

  Future<dynamic> loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin.value = prefs.getBool('isLogin') ?? false;
    Id = prefs.getString('employee_id') ?? "";
    id1 = prefs.getInt("id") ?? 0;
    print("id in pref $Id");
    print("id in pref $id1");

  }

  Future<dynamic> loginUser() async {
    final String UserName = usernameController.text;
    final String Password = passwordController.text;
    try {
      isLoading.value = true;
      var response = await authService.login(
        UserName,
        Password,

      );
      var responseData;
      print(response);
      response.fold(
            (failure) {
          responseData .clear();
          print('Failure in login  : ${failure.message}');
          responseData = 'Failure in login: ${failure.message}';
        },
            (res) => responseData = res,
      );

      if (responseData != null ) {
        isLogin.value = true;
        saveLoginState();
        Get.off(() => const HomeScreen());
      } else {
        isLogin.value = false;
        saveLoginState();
      }

      return responseData;
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to login: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> logOutUser() async {
    isLogin.value = false;
    Id = "";
    id1 = 0;
    await saveLoginState();
    Get.off(() => const LoginScreen());
  }

  Future<void> saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', isLogin.value);
    if (isLogin.value) {
      prefs.setString('employee_id', Id);
      prefs.setInt('id', id1);
    } else {
      prefs.remove('employee_id');
      prefs.remove('id');
    }
  }

}