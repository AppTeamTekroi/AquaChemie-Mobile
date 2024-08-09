import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:aquachemicals/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TeamleavesRepository {
  Future<Either<Failure, dynamic>> fetchdutyfilter(String type,String filter);
  Future<Either<Failure, dynamic>> fetchleavefilter(String type,String filter);
  Future<Either<Failure, dynamic>> fetchvactionfilter(String type,String filter);
}

class TeamleavesDataSourceImpl implements TeamleavesRepository {
  Future<int> _getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id') ?? 0;
  }

  @override
  Future<Either<Failure, dynamic>> fetchdutyfilter(String type,String filter) async {
    try {
      print('going on datasource');

      final id1 = await _getId();
      print(id1);
      final response = await http.get(Uri.parse("https://support.aquachemie.com/api/employee-duty-leaves/$id1/$type?$filter"));
      if (response.statusCode == 200) {
        print("c 1st one${response.body} ");
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Right(jsonResponse);
      } else {
        return Left(Failure(statusCode: response.statusCode, message: 'Failed to fetch duty filtertype data'));
      }
    } catch (e) {
      return Left(Failure(statusCode: 500, message: 'Error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchleavefilter(String type,String filter) async {
    try {
      print('going on datasource');

      final id1 = await _getId();
      print(id1);

      final response = await http.get(Uri.parse("https://support.aquachemie.com/api/employee-leaves/$id1/$type?$filter"));

      if (response.statusCode == 200) {
        print("2nd one${response.body}");

        final Map<String, dynamic> leaveResponse = json.decode(response.body);
        return Right(leaveResponse);
      } else {
        return Left(Failure(statusCode: response.statusCode, message: 'Failed to fetch leave filtertype  data'));
      }
    } catch (e) {
      return Left(Failure(statusCode: 500, message: 'Error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchvactionfilter(String type,String filter) async {
    try {
      print('going on datasource');

      final id1 = await _getId();
      final response = await http.get(Uri.parse("https://support.aquachemie.com/api/employee-business-approval/$id1/$type?$filter"));
      if (response.statusCode == 200) {
        print("3rd one${response.body}");

        final Map<String, dynamic> vacationResponse = json.decode(response.body);
        return Right(vacationResponse);
      } else {
        return Left(Failure(statusCode: response.statusCode, message: 'Failed to fetch vacation filtertype data'));
      }
    } catch (e) {
      return Left(Failure(statusCode: 500, message: 'Error occurred: $e'));
    }
  }
}
