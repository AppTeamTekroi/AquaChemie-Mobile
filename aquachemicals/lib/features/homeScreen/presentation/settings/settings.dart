import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../login/controller/login_controller.dart';
import '../../../../login/presentation/loginScreen.dart';
import '../../../../ui/color/appColor.dart';
import 'controller/controller.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.17,
                width: w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),

                  image: DecorationImage(
                    image: AssetImage('lib/ui/assets/banner-bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Profile",
                      style: GoogleFonts.gupter(
                        textStyle: TextStyle(color: AppColors.b, fontSize: 27),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var user = userController.userResponse.value.user;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(Icons.person),
                                  ),

                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.blues,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          user.mobile ?? '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.blues,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [

                                        Expanded(
                                          child: Text(
                                            user.email,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.blues,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2,),
                                    Row(
                                      children: [
                                        Text(
                                          user.designation ?? '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.blues,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "UserId:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.id.toString() ?? " ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Employ Id:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.employeeId ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Department:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.department ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Employer:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.employeer ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Blood Group:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.employeeBloodGroup ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Joining Date:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.joiningDate ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Headquarters:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.headQuarter ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120, // Adjust width to align with other labels
                                      child: Text(
                                        "Region:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppColors.blues,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.region ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )

                        ),
                        SizedBox(height: h*0.148),



                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "LogOut Confirmation",
                                titleStyle: const TextStyle(fontSize: 20),
                                content: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text("Are you sure, you want to Logout?"),
                                ),
                                confirm: ElevatedButton(
                                  onPressed: () async {
                                    final LoginController loginController = Get.find();
                                    await loginController.logOutUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    side: BorderSide.none,
                                  ),
                                  child: const Text("Yes"),
                                ),
                                cancel: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("No"),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Logout', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.b,
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.blues,
            ),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColors.blues),
        ),
        trailing: endIcon
            ? Icon(LineAwesomeIcons.angle_right, size: 18.0, color: AppColors.blues)
            : null,
      ),
    );
  }
}
