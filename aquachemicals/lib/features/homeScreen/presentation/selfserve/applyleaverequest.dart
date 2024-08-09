import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../ui/color/appColor.dart';

class ApplyLeaveRequest extends StatefulWidget {
  const ApplyLeaveRequest({super.key});

  @override
  State<ApplyLeaveRequest> createState() => _ApplyLeaveRequest();
}

class _ApplyLeaveRequest extends State<ApplyLeaveRequest> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int _selectedIndex = 0;
  String _selectedLeave = "Casual Leave";
  final List<String> _typeofleaves = [
    "Casual Leave",
    "Annual Leave",
    "Sick Leave",
    "Paternal Leave",
    "Maternity Leave"
  ];

  final List<Widget> _pages = [
    //NotificationsPage(),
    //ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      Get.off(HomeScreen());
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> submitLeaveRequest() async {
    final String startDate = _startDateController.text;
    final String endDate = _endDateController.text;
    final String typeOfLeave = _selectedLeave;
    final String description = _descriptionController.text;

    if (startDate.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the date",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        // Set gravity to center
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    if(endDate.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the date",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        // Set gravity to center
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    if(typeOfLeave.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the type of leave",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        // Set gravity to center
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    if(description.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the description",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        // Set gravity to center
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('employee_id') ?? "";
    final int id1 = prefs.getInt('id') ?? 0;

    print('employee id from SharedPreferences: $id');
    final url = Uri.parse('https://support.aquachemie.com/api/emp-leaves'); // Replace with your API URL
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "user_id":id1,

      "employee_id":id,
      'start_date': startDate,
      'end_date': endDate,
      'type_of_leave': typeOfLeave,
      'description': description,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Duty request submitted successfully',
        ).then((_) => Get.off(() =>HomeScreen())
        );
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Failed to submit duty request',
        ).then((_) => Get.off(() =>HomeScreen())
        );
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      ).then((_) => Get.off(() =>HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
          backgroundColor: AppColors.blues,
          centerTitle: true,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios),color: AppColors.b,),

          title:Text("Apply Leave Request",style: GoogleFonts.gupter(
              textStyle: TextStyle(color: AppColors.b, fontSize: h*0.035)),)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Start Date"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  controller: _startDateController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'YYYY-MM-DD',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: h*0.02,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.only(left: 12, top: 7),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _startDateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              const Text("End Date"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  controller: _endDateController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'YYYY-MM-DD',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: h*0.02,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.only(left: 12, top: 7),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _endDateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              const Text("Type Of Leave"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: DropdownButton<String>(
                  value: _selectedLeave,
                  items: _typeofleaves.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time, style: TextStyle(fontSize: h*0.02)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLeave = newValue!;
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              const Text("Description"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.12,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500),
                    contentPadding: const EdgeInsets.only(left: 12, top: 7),
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        submitLeaveRequest();
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blues,
                        foregroundColor: AppColors.b
                    ),
                      child: Text("Submit Request"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}