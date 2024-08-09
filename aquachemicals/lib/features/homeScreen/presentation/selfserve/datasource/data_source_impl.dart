import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aquachemicals/features/homeScreen/presentation/selfserve/model/employeleave_model.dart';

class ApiService {
  final String apiUrl = "https://yourapiurl.com/employees/leaves";

  Future<EmployeeLeaveList> fetchEmployeeLeaves() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return EmployeeLeaveList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load employee leaves');
    }
  }
}
