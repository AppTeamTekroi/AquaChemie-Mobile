import 'package:aquachemicals/login/presentation/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:aquachemicals/login/controller/login_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    final LoginController loginController = Get.put(LoginController());
    await loginController.loadLoginState();
    return loginController.isLogin.value;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'aquachemicals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.hasData && snapshot.data == true) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
