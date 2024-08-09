import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aquachemicals/ui/color/appColor.dart';
import 'package:aquachemicals/ui/richtext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'controller/teamleaves_controller.dart';



class TeamLeaves extends StatefulWidget {
  @override
  _TeamLeavesState createState() => _TeamLeavesState();
}

class _TeamLeavesState extends State<TeamLeaves> {
  final TeamLeavesController controller = Get.put(TeamLeavesController());
  String _selectedFilter = "This month";
  String _selectedLeave = "myself";

  String? _filter;
  DateTime? _fromDate;
  DateTime? _toDate;

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _updateFilter() {
    switch (_selectedFilter) {
      case 'this month':
        _filter = 'filter=this_month';
        break;
      case 'last month':
        _filter = 'filter=last_month';
        break;
      case 'last year':
        _filter = 'filter=last_year';
        break;
      case 'current year':
        _filter = 'filter=current_year';
        break;
      case 'Choose dates':
        if (_fromDate != null && _toDate != null) {
          final fromDateFormatted = _fromDate!.toIso8601String().split('T').first;
          final toDateFormatted = _toDate!.toIso8601String().split('T').first;
          _filter = 'fromdate=$fromDateFormatted&todate=$toDateFormatted';
        } else {
          _filter = null;
        }
        break;
      default:
        _filter = 'filter=this_month';
    }
  }

  Future<void> _fetchData() async {
    _updateFilter();
    if (_filter != null) {
      await Future.wait([
        controller.getdutylist(_selectedLeave, _filter!),
        controller.getleavelist(_selectedLeave, _filter!),
        controller.getvactionlist(_selectedLeave, _filter!),
      ]);
    }
  }

  Future<void> _showDatePickerDialog(BuildContext context, bool isFromDate) async {
    final DateTime initialDate = isFromDate ? _fromDate ?? DateTime.now() : _toDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromDateController.text = picked.toLocal().toString().split(' ')[0];
        } else {
          _toDate = picked;
          _toDateController.text = picked.toLocal().toString().split(' ')[0];
        }
      });
    }
  }

  Future<void> _showDateSelectionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Dates'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('From Date'),
                  TextField(
                    controller: _fromDateController,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          await _showDatePickerDialog(context, true);
                          setState(() {});
                        },
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  Text('To Date'),
                  TextField(
                    controller: _toDateController,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          await _showDatePickerDialog(context, false);
                          setState(() {});
                        },
                      ),
                    ),
                    readOnly: true,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateFilter();
                    _fetchData();
                  },
                  child: Text('Apply'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onDropdownChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        if (newValue == 'Choose dates') {
          _selectedFilter = newValue;
          _showDateSelectionDialog(context);
        } else {
          _selectedFilter = newValue;
          _updateFilter();
          _fetchData();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team Leaves",
                        style: GoogleFonts.gupter(
                          textStyle: TextStyle(color: AppColors.b, fontSize: 27),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: h* 0.03,
                        padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(5.0), // Border radius
                        ),
                        child:  DropdownButton<String>(
                          value: _selectedLeave,
                          dropdownColor: Colors.blue,
                          icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
                          underline: Container(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedLeave = newValue;
                                _fetchData(); // Refresh data when leave type changes
                              });
                            }
                          },
                          items: <String>['myself', 'all'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.white,fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),

                      Container(
                        height: h* 0.03,
                        padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(5.0), // Border radius
                        ),
                        child:
                        DropdownButton<String>(
                          value: _selectedFilter,
                          dropdownColor: Colors.blue, // Dropdown background color
                          icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.white), // Icon color
                          underline: Container(), // Remove underline
                          onChanged: _onDropdownChanged,
                          items: <String>[
                            'This month',
                            'last month',
                            'last year',
                            'current year',
                            'Choose dates'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.white,fontSize: 12)), // Dropdown item text color
                            );
                          }).toList(),
                        ), ),
                    ]
                )
              ],
              backgroundColor: AppColors.blues,
              bottom: TabBar(
                tabs: [
                  Tab(text: "On Duty"),
                  Tab(text: "Leave"),
                  Tab(text: "Travel"),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
              ),
            ),
            body: TabBarView(children: [
              Stack(
                children: [
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.errorMessage1.value.isNotEmpty) {
                      return Center(
                          child: Text(controller.errorMessage1.value));
                    } else if (controller.dutyfilterdata.value.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      var dutyMap = controller.dutyfilterdata.value
                      as Map<String, dynamic>? ??
                          {};
                      var employeeOnDutyList =
                          dutyMap['EmployeeLeaves'] as List<dynamic>? ?? [];
                      if (employeeOnDutyList.isEmpty) {
                        return Center(child: Text('No leaves available'));
                      }
                      return ListView.builder(
                        itemCount: employeeOnDutyList.length,
                        itemBuilder: (context, index) {
                          var onDuty =
                          employeeOnDutyList[index] as Map<String, dynamic>;
                          return Card(
                            elevation: 2,
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      onDuty['first_name'] ?? '',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CommonRichText(
                                          label:'Place: ',
                                          value: onDuty['place_name'] ?? '',
                                        ),
                                        CommonRichText(
                                          label:'Date: ',
                                          value: onDuty['date_time'] ?? '',

                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
              ///////////////////////////////////leaves
              Stack(children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage1.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage1.value));
                  } else if (controller.leavefilterdata.value.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var dutyMap = controller.leavefilterdata.value
                    as Map<String, dynamic>? ??
                        {};
                    var employeeOnDutyList =
                        dutyMap['EmployeeLeaves'] as List<dynamic>? ?? [];
                    if (employeeOnDutyList.isEmpty) {
                      return Center(child: Text('No leaves available'));
                    }
                    return ListView.builder(
                        itemCount: employeeOnDutyList.length,
                        itemBuilder: (context, index) {
                          var leave =
                          employeeOnDutyList[index] as Map<String, dynamic>;
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
                                  child: Column(children: [
                                    ListTile(
                                      title: Text(
                                        leave['first_name'] ?? '',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle:
                                      // 'Id: ${onDuty['id'] ?? ''} \n'
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [ CommonRichText(
                                              label: 'Start Date: ',
                                              value: leave['start_date'] ?? '',
                                            ),
                                              CommonRichText(
                                                label: 'End Date: ',
                                                value: leave['end_date'] ?? '',
                                              ),],),
                                          CommonRichText(
                                            label: 'Reason: ',
                                            value: leave['type_of_leave'] ?? '',
                                          ),


                                        ],
                                      ),
                                    )
                                  ])));
                        });
                  }
                })
              ]),
              Stack(children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage3.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage3.value));
                  } else if (controller.vacationfilterdata.value.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var vacation = controller.vacationfilterdata.value
                    as Map<String, dynamic>? ??
                        {};
                    var vacationMap =
                        vacation['EmployeeLeaves'] as List<dynamic>? ?? [];
                    if (vacationMap.isEmpty) {
                      return Center(child: Text('No leaves available'));
                    }
                    return ListView.builder(
                        itemCount: vacationMap.length,
                        itemBuilder: (context, index) {
                          var vacation =
                          vacationMap[index] as Map<String, dynamic>;
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
                                  child: Column(children: [
                                    ListTile(
                                      title: Text(
                                        vacation['first_name'] ?? '',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle:
                                      // 'Id: ${onDuty['id'] ?? ''} \n'
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CommonRichText(
                                            label: 'Place of Visit: ',
                                            value: vacation['place_of_visit'] ?? '',
                                          ),
                                          CommonRichText(
                                            label: 'No.of Days : ',
                                            value: vacation['number_of_days'] ?? '',
                                          ),

                                        ],
                                      ),
                                    )
                                  ])));
                        });
                  }
                }),

              ])
            ])));
  }
}