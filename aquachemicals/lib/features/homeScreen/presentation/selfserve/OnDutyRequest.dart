import 'dart:convert';
import 'dart:core';
import 'package:aquachemicals/features/homeScreen/presentation/selfserve/selfserve.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnDutyRequest extends StatefulWidget {
  const OnDutyRequest({super.key});

  @override
  State<OnDutyRequest> createState() => _OnDutyRequestState();
}

class _OnDutyRequestState extends State<OnDutyRequest> {
  final TextEditingController _timePeriodController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _AstartTimeController = TextEditingController();
  final TextEditingController _employeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _customerVisitDetailsController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _AendTimeController = TextEditingController();
  final TextEditingController _comingController = TextEditingController();
  final TextEditingController _goingController = TextEditingController();

  int _selectedIndex = 0;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  TimeOfDay? _specificStartTime;
  TimeOfDay? _specificEndTime;

  String _selectedShift = "";
  String _selectedLeave = "Select";



  String customer_name = '';
  final List<String> _typeofDutyLeaves = [
    "Select",
    "Customer Visit",
    "Authority",
    "Work From Home",
    "Early Going",
    "Late Coming"
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

  Future<void> _submitDutyRequest() async {
    final String date = (_dateController.text.isNotEmpty)? _dateController.text : '';
    final String place =( _placeController.text.isNotEmpty)? _placeController.text : '';
    final String reason = (_reasonController.text.isNotEmpty)? _reasonController.text: '';
    String customer_name = (_customerVisitDetailsController.text.isNotEmpty)? _customerVisitDetailsController.text: '';
    // String cust_auth = ;
    String start_time = (_startTimeController.text.isNotEmpty)? _startTimeController.text : '';
    String end_time  = (_endTimeController.text.isNotEmpty)? _endTimeController.text : '';
    String early_timing = (_goingController.text.isNotEmpty)? _goingController.text : '';
    String  late_timing= (_comingController.text.isNotEmpty)? _comingController.text : '';
    String employee_name= (_employeController.text.isNotEmpty)? _employeController.text : '';
    if (date.isEmpty || reason.isEmpty) {
      Fluttertoast.showToast(
        msg: 'fill all required',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
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

    final url = Uri.parse("https://support.aquachemie.com/api/emp-on-dutyrequest");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "user_id": id1,
      "employee_id": id,
      "place_name": place,
      "date_time": date,
      "reason": reason,
      //  "duty_request": _selectedShift,
      "customer_name" : customer_name,
      'cust_auth' : _selectedShift,
      'start_time' : start_time,
      'end_time' : end_time,
      'early_timing':early_timing,
      'late_timing':late_timing,
      "duty_request": _selectedLeave,
      'employee_name' : employee_name,
    });

    print('$body*');

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Duty request submitted successfully',
        ).then((_) => Get.off(HomeScreen()));
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Failed to submit duty request',
        ).then((_) => Get.off(HomeScreen()));
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      ).then((_) => Get.off(HomeScreen()));
    }
  }

  void _calculateTimePeriod() {
    if (_startTime != null && _endTime != null) {
      final now = DateTime.now();
      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _startTime!.hour,
        _startTime!.minute,
      );
      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _endTime!.hour,
        _endTime!.minute,
      );

      final duration = endDateTime.difference(startDateTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      setState(() {
        _timePeriodController.text = "${hours}h ${minutes}m";
      });
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
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: AppColors.blues,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.b,
          ),
        ),
        title: Text(
          "On Duty Request",
          style: GoogleFonts.gupter(
            textStyle: TextStyle(color: AppColors.b, fontSize: h*0.035),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Type Of Duty"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: DropdownButton<String>(
                  value: _selectedLeave,
                  items: _typeofDutyLeaves.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time, style: TextStyle(fontSize: h*0.02)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLeave = newValue!;
                      _selectedShift = "";
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              if (_selectedLeave == "Customer Visit") ...[
                Text("Customer/Authority/Others Visit Details", style: TextStyle(color: AppColors.blues)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: h*0.07,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextFormField(
                    controller: _customerVisitDetailsController,
                    style: TextStyle(
                      fontSize: h*0.02,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Customer/Authority/Others',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12, top: 7),
                    ),
                  ),
                ),
                Text("Place", style: TextStyle(color: AppColors.blues)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: h*0.07,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextFormField(
                    controller: _placeController,
                    style: TextStyle(
                      fontSize: h*0.02,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Place Name',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12, top: 7),
                    ),
                  ),
                ),
                RadioListTile(
                  title: const Text("First Half"),
                  value: "First Half",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Second Half"),
                  value: "Second Half",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Full Day"),
                  value: "Full Day",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Specific Time"),
                  value: "Specific Time",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                if (_selectedShift == "Specific Time") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: h*0.02,
                        ),
                      ),
                      Container(
                        height: h*0.06,
                        width: w*0.57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _startTimeController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _startTime = picked;
                                _startTimeController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h*0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'End Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: h*0.02,
                        ),
                      ),
                      Container(
                        height: h*0.06,
                        width: w*0.57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _endTimeController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _endTime = picked;
                                _endTimeController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time Period:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _timePeriodController,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ]
              ],



              if (_selectedLeave == "Authority") ...[
                Text("Authorty/Customer/Others Visit Details", style: TextStyle(color: AppColors.blues)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: h*0.06,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextFormField(
                    controller: _customerVisitDetailsController,
                    style: TextStyle(
                      fontSize: h*0.02,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Authority/Customer/Others',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12, top: 7),
                    ),
                  ),
                ),
                Text("Place", style: TextStyle(color: AppColors.blues)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: h*0.06,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextFormField(
                    controller: _placeController,
                    style: TextStyle(
                      fontSize: h*0.02,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Place Name',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12, top: 7),
                    ),
                  ),
                ),
                RadioListTile(
                  title: const Text("First Half"),
                  value: "First Half",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Second Half"),
                  value: "Second Half",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Full Day"),
                  value: "Full Day",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Specific Time"),
                  value: "Specific Time",
                  groupValue: _selectedShift,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedShift = value ?? "";
                    });
                  },
                ),
                if (_selectedShift == "Specific Time") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: h*0.02,
                        ),
                      ),
                      Container(
                        height: h*0.06,
                        width: w*0.57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _AstartTimeController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _startTime = picked;
                                _AstartTimeController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h*0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'End Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: h*0.02,
                        ),
                      ),
                      Container(
                        height: h*0.06,
                        width: w*0.57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _AendTimeController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _endTime = picked;
                                _AendTimeController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time Period:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _timePeriodController,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ]
              ],

              // if (_selectedLeave == "Work From Home") ...[
              //   const SizedBox(height: 10),
              //
              // ],


              if (_selectedLeave == "Early Going") ...[
                Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Early going:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: h*0.02,
                          ),
                        ),
                      ),
                      Container(
                        height: h*0.07,
                        width: w*0.58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _goingController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _startTime = picked;
                                _goingController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ]
                ),
              ],

              if (_selectedLeave == "Late Coming") ...[
                Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Late Coming:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: h*0.02,
                          ),
                        ),
                      ),
                      Container(
                        height: h*0.07,
                        width: w*0.58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: _comingController,
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _startTime = picked;
                                _comingController.text = picked.format(context);
                              });
                              _calculateTimePeriod();
                            }
                          },
                          style: TextStyle(
                            fontSize: h*0.02,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 12, top: 7),
                          ),
                        ),
                      ),
                    ]
                ),
              ],


              Text("Date", style: TextStyle(color: AppColors.blues)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  controller: _dateController,
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
                        _dateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),

              Text("Reason", style: TextStyle(color: AppColors.blues)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.12,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  controller: _reasonController,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Reason',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: h*0.02,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () {
                    _submitDutyRequest();
                  },style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blues,
                      foregroundColor: AppColors.b
                  ),
                      child: Text("Submit Request"))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}