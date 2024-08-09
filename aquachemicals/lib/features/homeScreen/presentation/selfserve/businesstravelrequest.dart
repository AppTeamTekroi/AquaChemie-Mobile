import 'dart:convert';
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessTravel extends StatefulWidget {
  const BusinessTravel({super.key});

  @override
  State<BusinessTravel> createState() => _BusinessTravelState();
}

class _BusinessTravelState extends State<BusinessTravel> {

  TextEditingController _placeController = TextEditingController();
  TextEditingController _visitController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _daysController = TextEditingController();
  TextEditingController _startdateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();

  Future<void> _submittravelRequest() async{
    final String place = _placeController.text;
    final String visit = _visitController.text;
    final String description = _descriptionController.text;
    final String name = _nameController.text;
    final String days = _daysController.text;
    final String startDate = _startdateController.text;
    final String endDate = _enddateController.text;


    if (place.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the place",
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

    if (visit.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the visit",
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

    if (description.isEmpty) {
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

    if (name.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the name",
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

    if (days.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill the days",
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

    if (endDate.isEmpty) {
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('employee_id') ?? "";
    final int id1 = prefs.getInt('id') ?? 0;

    print('employee id from SharedPreferences: $id');
    final url = Uri.parse('https://support.aquachemie.com/api/business-travel-approval');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "user_id":id1,
      "employee_id":id,
      "place_of_visit": place,
      "purpose_of_visit": visit,
      "short_description": description,
      "customer_name": name,
      "number_of_days": days,
      "start_date": startDate,
      "end_date": endDate,
    });
    print(body);
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Business Travel request submitted successfully',
        ).then((_) => Get.off(HomeScreen())
        );
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Failed to submit business request',
        ).then((_) => Get.off(HomeScreen())
        );
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      ).then((_) => Get.off(HomeScreen())
      );
    }
  }
  DateTime? _startDate;
  DateTime? _endDate;


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

          title:Text("Business Travel Request",style: GoogleFonts.gupter(
              textStyle: TextStyle(color: AppColors.b, fontSize: h*0.035)),)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Place of Visit"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: TextFormField(
                  controller: _placeController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the place of visit',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500),
                    contentPadding:
                    const EdgeInsets.only(left: 12, top: 7),

                  ),
                ),
              ),
              const Text("Purpose of Visit"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: TextFormField(
                  controller: _visitController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the purpose of visit',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500),
                    contentPadding:
                    const EdgeInsets.only(left: 12, top: 7),

                  ),
                ),
              ),
              const Text("Short Description"),
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
                    hintText: 'Enter a short description',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500),
                    contentPadding:
                    const EdgeInsets.only(left: 12, top: 7),

                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              const Text("Customer Name (if applicable)"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: TextFormField(
                  controller: _nameController,
                  style: TextStyle(
                    fontSize: h*0.02,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter the customer's name",
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: h*0.02,
                        fontWeight: FontWeight.w500),
                    contentPadding:
                    const EdgeInsets.only(left: 12, top: 7),

                  ),
                ),
              ),

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
                  controller: _startdateController,
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
                  readOnly: true, // Prevents the keyboard from appearing
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _startDate = pickedDate;
                        _startdateController.text = formattedDate;
                        _calculateDays();
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
                  controller: _enddateController,
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
                  readOnly: true, // Prevents the keyboard from appearing
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _endDate = pickedDate;
                        _enddateController.text = formattedDate;
                        _calculateDays();

                      });
                    }
                  },
                ),
              ),
              const Text("Number of Days"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: h*0.07,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: TextFormField(
                  controller: _daysController,
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
                    contentPadding:
                    const EdgeInsets.only(left: 12, top: 7),

                  ),
                  readOnly: true,

                ),
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () {
                    _submittravelRequest();
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

  void _calculateDays() {
    if (_startDate != null && _endDate != null) {
      final duration = _endDate!.difference(_startDate!);
      final days = duration.inDays;
      setState(() {
        _daysController.text = "$days days";
      });
    }
  }
}