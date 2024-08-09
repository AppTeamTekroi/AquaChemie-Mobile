import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aquachemicals/ui/Buttons/CustomButton.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:aquachemicals/login/presentation/loginScreen.dart';
//////////////////////////////////////not in use//////////////////////////////
class LoginORReg extends StatefulWidget {
  const LoginORReg({super.key});

  @override
  State<LoginORReg> createState() => _LoginORRegState();
}

class _LoginORRegState extends State<LoginORReg> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/ui/assets/backvertical.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.10),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.075),
                  child: const Text(
                    "Self-Serve!",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 2,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.075,
                    right: width * 0.075,
                    top: width * 0.045,
                    bottom: width * 0.075,
                  ),
                  child: Text(
                    "AquaChemie forays into the areas of chemical manufacturing, sales, distribution, services and terminal storage. Our physical assets include corporate offices, manufacturing facilities, a chemical storage terminal, warehouses, fleets of ISO tanks and multiple operation skids.",
                    style: TextStyle(
                      fontSize: 16, // Adjusted font size for readability
                      letterSpacing: 1.5,
                      color: Color(0xffC4DFCB),
                      fontWeight: FontWeight.w400, // Adjusted font weight for a professional look
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.075, vertical: width * 0.035),
                  child: Column(
                    children: [
                      // Login Button
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginScreen());
                          print('Login tapped');
                        },
                        child: Container(
                          height: 40,

                          width: double.infinity,
                        //  padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color:Colors.white24,
                         //  border: Border.all(color: Colors.white60, width: 1), // Border color and width
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          //  color: Colors.transparent, // Transparent background
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xffC4DFCB),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Spacing between buttons
                      // Sign Up Button
                      GestureDetector(
                        onTap: () {
                          // Add your sign logic here
                          print('Sign Up tapped');
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                       //   padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color:Colors.white24,

                           // border: Border.all(color: Colors.black, width: 1), // Border color and width
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          //  color: Colors.transparent, // Transparent background
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xffC4DFCB),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
