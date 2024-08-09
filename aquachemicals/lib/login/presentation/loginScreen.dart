import 'package:aquachemicals/login/controller/login_controller.dart';
import 'package:aquachemicals/ui/Buttons/CustomButton.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aquachemicals/login/presentation/login-Reg.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController(), permanent: true);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                  height: height*0.23,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                   //   bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(120),
                    ),
                    image: DecorationImage(
                      image: AssetImage('lib/ui/assets/1OND.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
        //           child:   Padding(
        //               padding: const EdgeInsets.only(top: 40,left: 7),
        //             child:Align(
        //
        //               alignment: Alignment.topLeft,
        //               child:
        //                IconButton(onPressed: () => Get.to(() => const LoginORReg()), icon: Icon(Icons.arrow_back_ios,color: AppColors.white,)),
        // ),
        //           ),
                  ),
                    SizedBox(
                      height: height * 0.02,
                    ),


                        Container(child: Column(children: [
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child:
                            Center(child:
                                Row(children: [
                                 Expanded(child:  Container(
                                    height: height*0.15,
                                    width: width*0.25,
                                    decoration: BoxDecoration(

                                      image: DecorationImage(
                                        image: AssetImage('lib/ui/assets/side12.jpeg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),),
                              Column(children: [
                                Text(
                                  "Welcom Back!",
                                  style: TextStyle(
                                      fontSize: 32,
                                      letterSpacing: 2,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "Login To Your Account!",
                                  style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 2,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900),
                                ),

                              ],),
                             ],
                            ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.01,
                          right: width * 0.01,
                          top: width * 0.001,
                          bottom: width * 0.075),
                      child: Container(
                     //   height: height * 0.44,
                        width: width * 0.91,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            //  Text('UserName',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(9)),
                                child: TextFormField(
                                  controller: loginController.usernameController,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'email',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    contentPadding:
                                    const EdgeInsets.only(left: 12, top: 7),
                                    prefixIcon: Icon(Icons.person,color: Colors.blue[900]),
                                  ),

                                  onChanged: (val) {
                                    loginController.UserName.value = val;
                                    print(val);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                             // Text('Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                              Obx(
                                    () => Container(
                                    margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: TextFormField(
                                      obscureText:
                                      loginController.isPasswordVisible.value,
                                      controller:
                                      loginController.passwordController,
                                      obscuringCharacter: '*',
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        contentPadding: const EdgeInsets.only(
                                            left: 12, top: 14),
                                        prefixIcon: Icon(Icons.password_outlined,color: Colors.blue[900],),

                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              loginController
                                                  .togglePasswordVisibility();
                                            },
                                            child: loginController
                                                .isPasswordVisible.value
                                                ? const Icon(
                                              Icons.visibility_off,
                                              color: AppColors.mainblue,
                                            )
                                                : const Icon(
                                              Icons.visibility,
                                              color: AppColors.mainblue,
                                            )),
                                      ),
                                      onChanged: (value) {
                                        loginController.Password.value = value;
                                        print(value);

                                      },
                                    )),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Obx(
                                    () => Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Center(
                                    child: CustomButton(
                                      title: 'Login',
                                      buttonText:
                                      loginController.isLoading.value == true
                                          ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                          : const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      backgroundColor: Colors.blue[900],
                                      height: 40,
                                      width: width * 0.9,
                                      borderRadius: 12,

                                      onPressed: () async {
                                        if (
                                         loginController
                                             .usernameController.text.isEmpty ||
                                            loginController
                                                .passwordController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: "Please enter credentials",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          return;
                                        }

                                        // final username = loginController
                                        //     .usernameController.text;
                                        // final isNumeric =
                                        // RegExp(r'^\d+$').hasMatch(username);
                                        //
                                        // if (!isNumeric) {
                                        //   QuickAlert.show(
                                        //       context: context,
                                        //       title: 'Failed',
                                        //       type: QuickAlertType.error,
                                        //       text:
                                        //       'Failed to login. Please try again later');
                                        // } else {
                                          try {
                                            print("calling login.....");
                                            final response =
                                            await loginController.loginUser();

                                            if (response != null &&
                                                response['data']['user']
                                                ['employee_id'] !=
                                                    null) {
                                              loginController.Id =
                                              response['data']['user']
                                              ['employee_id'];
                                              loginController.id1 = response['data']['user']['id'];
                                              final SharedPreferences _prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                              _prefs.setString('employee_id',loginController.Id);
                                              _prefs.setInt('id', loginController.id1);

                                              loginController.usernameController
                                                  .clear();
                                              loginController.passwordController
                                                  .clear();

                                              Get.off(() => HomeScreen());
                                              return; // Exit the function after successful login
                                            } else if (response["error"] !=
                                                null) {
                                              QuickAlert.show(
                                                context: context,
                                                title: 'Failed',
                                                type: QuickAlertType.error,
                                                text: 'Check login credentials',
                                              );
                                            } else {
                                              QuickAlert.show(
                                                context: context,
                                                title: 'Failed',
                                                type: QuickAlertType.error,
                                                text: 'Server error',
                                              );
                                            }
                                          } catch (e) {
                                            print('Server error: $e');
                                            QuickAlert.show(
                                              context: context,
                                              title: 'Failed',
                                              type: QuickAlertType.error,
                                              text:
                                              'Failed to login. Please try again later.',
                                            );
                                          } finally {
                                            loginController.isLoading.value =
                                            false;
                                          }

                                        loginController.isLogin.value = false;
                                      },

                                    ),




                                  ),
                                ),
                              ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.black, // Color for the first part
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue[900], // Color for the "Sign Up" part
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Handle the "Sign Up" tap action here
                                  print("Sign Up tapped");
                                },
                              ),
                            ],
                          ),
                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.15,
                    ),

                    Align(
                        alignment: Alignment.bottomRight,
                        child:Padding(
                    padding: const EdgeInsets.only(right: 6),child:  Text('Powered By')),
                    ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child:Padding(
                              padding: const EdgeInsets.all(6.0),child: Image(
                              //  width: MediaQuery.of(context).size.width,
                              height: height * 0.05, // Adjust the height of the image
                              image: AssetImage('lib/ui/assets/my.png'),
                            ),),
                          ),
                  ],
                ),
              ),

])
        )
    );
  }
}
