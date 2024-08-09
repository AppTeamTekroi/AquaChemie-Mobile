import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OnDutyRequest.dart';
import 'applyleaverequest.dart';
import 'businesstravelrequest.dart';
import 'package:aquachemicals/ui/richtext.dart';
import 'package:google_fonts/google_fonts.dart';

class SelfServe extends StatefulWidget {
  const SelfServe({Key? key}) : super(key: key);

  @override
  State<SelfServe> createState() => _SelfServeState();
}

class _SelfServeState extends State<SelfServe> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
          children: [
            Container(
              height: h * 0.17,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
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
                    "HomeScreen",
                    style: GoogleFonts.gupter(
                        textStyle: TextStyle(color: AppColors.b, fontSize: 27)),
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              child: Column(
                children: [


                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Container(
                      width: w,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade200,Colors.white,Colors.blue.shade900],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        //border: Border.all(
                        //   width: 2,
                        // ),
                      ),
                      child:  Padding(
                        padding: EdgeInsets.all(16),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Leaves",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blue[900]),
                            ),
                            SizedBox(height: h * 0.01),
                            CommonRichText(
                              label: "Annual Leave: ",
                              value: "12 days", // Example value
                            ),
                            SizedBox(height: h * 0.005),
                            CommonRichText(
                              label: "Sick Leave: ",
                              value: "5 days", // Example value
                            ),
                            SizedBox(height: h * 0.005),
                            CommonRichText(
                              label: "Casual Leave: ",
                              value: "3 days", // Example value
                            ),
                          ],
                        ),
                      ),),),
                  SizedBox(height: h * 0.02),
                  _buildActionContainer(
                    onTap: () {
                      Get.to(() => OnDutyRequest());
                    },
                    label: "Apply On-Duty Request",
                  ),
                  SizedBox(height: h * 0.02),
                  _buildActionContainer(
                    onTap: () {
                      Get.to(() => ApplyLeaveRequest());
                    },
                    label: "Apply Leave Request",
                  ),
                  SizedBox(height: h * 0.02),
                  _buildActionContainer(
                    onTap: () {
                      Get.to(() => BusinessTravel());
                    },
                    label: "Business Travel Request",
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildActionContainer({required VoidCallback onTap, required String label}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.b, // Button background color
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.blues,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}