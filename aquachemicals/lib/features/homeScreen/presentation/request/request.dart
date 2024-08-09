import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:aquachemicals/features/homeScreen/presentation/request/controller/request_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aquachemicals/features/homeScreen/presentation/selfserve/selfserve.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:aquachemicals/features/homeScreen/presentation/homeScreen.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aquachemicals/ui/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aquachemicals/ui/richtext.dart';


class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final RequestController controller = Get.put(RequestController());
  String _selectedLeave = "myself";
  bool _isProcessing1 = false;
  bool _isProcessing2 = false;
  bool _isProcessing3 = false;

  final Map<int, bool> _expandedMap = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    await controller.getdutylist(_selectedLeave);
    await controller.getleavelist(_selectedLeave);
    await controller.getvactionlist(_selectedLeave);
  }

  void _onDropdownChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedLeave = newValue;
        _fetchData(); // Call API when the dropdown value changes
      });
    }
  }

  Future<void> postdutyleavestatus(int status, int id, {String reason = ""}) async {
    print('calling duty');
    setState(() {
      _isProcessing1 = true; // Show the progress overlay
    });

    final url = Uri.parse("https://support.aquachemie.com/api/approval-status-onduty");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "id": id, // Use the ID parameter
      "approval_status": status,
      "rejected_reason": reason, // Include the reason in the request body
    });
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Duty request submitted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ).then((value) => controller.initState());
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Duty request failed to submit',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      );
    } finally {
      setState(() {
        _isProcessing1 = false; // Hide the progress overlay
      });
    }
  }

  Future<void> postleavestatus(int status, int id, {String reason = ""}) async {
    print('calling leave');
    setState(() {
      _isProcessing2 = true; // Show the progress overlay
    });

    final url = Uri.parse("https://support.aquachemie.com/api/leave-approval-status");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "id": id, // Use the ID parameter
      "approval_status": status,
      "rejected_reason": reason, // Include the reason in the request body
    });
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Leave request submitted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ).then((value) => controller.initState());
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Leave request failed to submit',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      );
    } finally {
      setState(() {
        _isProcessing2 = false; // Hide the progress overlay
      });
    }
  }

  Future<void> postvactionleavestatus(int status, int id, {String reason = ""}) async {
    print('calling vacation');
    setState(() {
      _isProcessing3 = true; // Show the progress overlay
    });

    final url = Uri.parse("https://support.aquachemie.com/api/business-approval-status");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "id": id, // Use the ID parameter
      "approval_status": status,
      "rejected_reason": reason, // Include the reason in the request body
    });
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Travel request submitted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ).then((value) => controller.initState());
      } else {
        print("Failed response status: ${response.statusCode}");
        print("Failed response body: ${response.body}");
        Fluttertoast.showToast(
          msg: 'Travel request failed to submit',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred',
      );
    } finally {
      setState(() {
        _isProcessing3 = false; // Hide the progress overlay
      });
    }
  }

  void _showRejectDialog(int id, Function(int, int, {String reason}) postStatusFunction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RejectionDialog(
          id: id,
          onSubmit: (reason) {
            postStatusFunction(2, id, reason: reason); // Call the provided post status function with the reason and ID
          },
        );
      },
    ); 
  }

  @override
  Widget build(BuildContext context) {
   final h = MediaQuery.of(context).size.height;
  final  w =MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: "On Duty"),
              Tab(text: "Leave"),
              Tab(text: "Travel"),
            ],
            labelColor: AppColors.b,
            unselectedLabelColor: Colors.white,
          ),
          title: Text('Leaves Approval', style: GoogleFonts.gupter(
              textStyle: TextStyle(color: AppColors.b, fontSize: h*0.035)),),
          backgroundColor: AppColors.blues,
          actions: [
            DropdownButton<String>(
              value: _selectedLeave,
              dropdownColor: AppColors.b,
              icon: Icon(Icons.arrow_drop_down_outlined, color: AppColors.b),
              underline: Container(),
              onChanged: _onDropdownChanged,
              items: <String>['myself', 'all'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white,fontSize: h*0.02)),
                );
              }).toList(),
            ),
          ],
        ),
        body: TabBarView(
          children: [
           ////////////////////////////////// On Duty Tab
            Stack(
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage1.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage1.value));
                  } else if (controller.dutydata.value.isEmpty) {
                    return Center(child: Text('No data available',style: TextStyle(color: Colors.black,fontSize: h*0.02)));
                  } else {
                    var dutyMap = controller.dutydata.value as Map<String, dynamic>? ?? {};
                    var employeeOnDutyList = dutyMap['EmployeeLeaves'] as List<dynamic>? ?? [];
                    if (employeeOnDutyList.isEmpty) {
                      return Center(child: Text('No leaves available',style: TextStyle(color: Colors.black,fontSize: h*0.02)));
                    }
                    return ListView.builder(
                      itemCount: employeeOnDutyList.length,
                      itemBuilder: (context, index) {
                        var onDuty = employeeOnDutyList[index] as Map<String, dynamic>;
                        bool isExpanded = _expandedMap[index] ?? false; // Check if item is expanded

                        return Card(
                          elevation: 2,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                ListTile(
                                  title: Text(onDuty['first_name'] ?? '',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  subtitle:
                                  // 'Id: ${onDuty['id'] ?? ''} \n'
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonRichText(
                                        label:'Place: ',
                                        value: onDuty['place_name'] ?? '',

                                      ),
                                      CommonRichText(
                                        label:'Date: ',
                                        value: onDuty['date_time'] ?? '',

                                      ),
                                      CommonRichText(
                                        label: 'Reason: ',
                                        value: onDuty['reason'] ?? '',
                                      ),

                                      if (onDuty['approval_status'] == 2) // Only show "Show More" if status is 2
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _expandedMap[index] = !isExpanded; // Toggle expansion
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (isExpanded) ...[
                                                  CommonRichText(
                                                    label: 'Rejected Reason: ',
                                                    value: onDuty['rejected_reason'] ?? '',
                                                  ),
                                                  SizedBox(height: 8),
                                                ],
                                                Text(
                                                  isExpanded ? 'Show Less' : 'Show More...',
                                                  style: TextStyle(fontSize: 15, color: Colors.blue),
                                                ),  
                                              ],
                                            ),
                        ),),
                                    ],

                                  ),
                                  trailing: onDuty['approval_status'] == 1
                                      ? Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage('lib/ui/assets/appr3.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Approved",
                                        style: GoogleFonts.gupter(
                                          textStyle: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : onDuty['approval_status'] == 2
                                      ? Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage('lib/ui/assets/reject.jpeg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Rejected",
                                        style: GoogleFonts.gupter(
                                          textStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : (onDuty['approval_status'] == 0 && _selectedLeave == "myself")
                                      ?Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage('lib/ui/assets/pending.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Pending",
                                        style: GoogleFonts.gupter(
                                          textStyle: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ):SizedBox.shrink(),
                                ),
                                if  (onDuty['approval_status'] == 0 && _selectedLeave == "all")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:
                                    [
                                      ElevatedButton(
                                        onPressed: () {
                                          postdutyleavestatus(1, onDuty['id']);
                                        },
                                        child: Text("Approve", style: TextStyle(
                                            color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(80, 40),
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showRejectDialog(
                                              onDuty['id'], postdutyleavestatus); // Pass the leave ID and function to the dialog
                                        },
                                        child: Text('Reject', style: TextStyle(
                                            color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(80, 40),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
                if (_isProcessing1)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54, // Semi-transparent background
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            /////////////////////////////////////////////////// // Leave Request Tab
            Stack(
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage2.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage2.value));
                  } else if (controller.leavedata.value.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var leaveMap = controller.leavedata.value as Map<String, dynamic>? ?? {};
                    var leaveList = leaveMap["EmployeeLeaves"] as List<dynamic>? ?? [];
                    if (leaveList.isEmpty) {
                      return Center(child: Text('No leaves available'));
                    }
                    return ListView.builder(
                      itemCount: leaveList.length,
                      itemBuilder: (context, index) {
                        var leave = leaveList[index];
                        bool isExpanded = _expandedMap[index] ?? false; // Check if item is expanded

                        return Card(
                          elevation: 2,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(h* 0.019,
                            ),
                          ),                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              ListTile(
                                title: Text(leave['first_name'] ?? '',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CommonRichText(
                                    //   label: 'Id',
                                    //   value: leave['id'] ?? 0,
                                    // ),
                                    CommonRichText(
                                      label: 'Start Date: ',
                                      value: leave['start_date'] ?? '',
                                    ),
                                    CommonRichText(
                                      label: 'End Date: ',
                                      value: leave['end_date'] ?? '',
                                    ),

                                    CommonRichText(
                                      label: 'Type : ',
                                      value: leave['type_of_leave'] ?? '',
                                    ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _expandedMap[index] = !isExpanded; // Toggle expansion
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (isExpanded) ...[
                                        Text('Description :${leave['description']}' ?? ''),
                                        SizedBox(height: 8),
                                      ],
                                      Text(
                                        isExpanded ? 'Show Less' : 'Show More...',
                                        style: TextStyle(fontSize: 15, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                  ],
                                ),


                                trailing: leave['approval_status'] == 1
                                    ? Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/appr3.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Approved",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : leave['approval_status'] == 2
                                    ? Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/reject.jpeg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rejected",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : (leave['approval_status'] == 0 && _selectedLeave == "myself")
                                    ?Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/pending.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Pending",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ):SizedBox.shrink(),
                              ),
                              if  (leave['approval_status'] == 0 && _selectedLeave == "all")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:
                                  [
                                    ElevatedButton(
                                      onPressed: () {
                                        postleavestatus(1, leave['id']);
                                      },
                                      child: Text("Approve", style: TextStyle(
                                          color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(80, 40),
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showRejectDialog(
                                            leave['id'], postleavestatus); // Pass the leave ID and function to the dialog
                                      },
                                      child: Text('Reject', style: TextStyle(
                                          color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(80, 40),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),

                            ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
                if (_isProcessing2)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54, // Semi-transparent background
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            // Business Travel Tab (implementation needed)



            ////////////////////////////////  // Business Travel Tab
            Stack(
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage3.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage3 .value));
                  } else if (controller.vacationdata.value.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var vacationMap = controller.vacationdata.value
                    as Map<String, dynamic>? ??
                        {};
                    var vacationlist =
                        vacationMap['EmployeeLeaves'] as List<dynamic>? ?? [];
                    if (vacationlist.isEmpty) {
                      return Center(child: Text('No leaves available'));
                    }
                    return ListView.builder(
                      itemCount: vacationlist.length,
                      itemBuilder: (context, index) {
                        var vacation = vacationlist[index];
                        bool isExpanded = _expandedMap[index] ?? false; // Check if item is expanded

                        return Card(
                          elevation: 2,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children:[
                              ListTile(
                                title: Text(vacation['first_name']?? '',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CommonRichText(
                                    //   label: 'Id',
                                    //   value: leave['id'] ?? 0,
                                    // ),
                                    CommonRichText(
                                      label: 'Start Date: ',
                                      value: vacation['start_date'] ?? '',
                                    ),
                                    CommonRichText(
                                      label: 'End Date: ',
                                      value: vacation['end_date'] ?? '',
                                    ),
                                    CommonRichText(
                                        label:'Place of Visit: ',

                                        value:vacation['place_of_visit'] ?? ','
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _expandedMap[index] = !isExpanded; // Toggle expansion
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (isExpanded) ...[
                                            Text('Description :${vacation['short_description']}' ?? ''),
                                            SizedBox(height: 8),
                                          ],
                                          Text(
                                            isExpanded ? 'Show Less' : 'Show More...',
                                            style: TextStyle(fontSize: 15, color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],),
                                trailing: vacation['approval_status'] == 1
                                    ? Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/appr3.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Approved",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : vacation['approval_status'] == 2
                                    ? Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/reject.jpeg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rejected",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : (vacation['approval_status'] == 0 && _selectedLeave == "myself")
                                    ?Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('lib/ui/assets/pending.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Pending",
                                      style: GoogleFonts.gupter(
                                        textStyle: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ):SizedBox.shrink(),
                              ),
                              if  (vacation['approval_status'] == 0 && _selectedLeave == "all")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:
                                  [
                                    ElevatedButton(
                                      onPressed: () {
                                        postvactionleavestatus(1, vacation['id']);
                                      },
                                      child: Text("Approve", style: TextStyle(
                                          color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(80, 40),
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showRejectDialog(
                                            vacation['id'],postvactionleavestatus); // Pass the leave ID to the dialog
                                      },
                                      child: Text('Reject', style: TextStyle(
                                          color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(80, 40),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),

                            ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
                if (_isProcessing3)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54, // Semi-transparent background
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

