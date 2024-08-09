import 'dart:convert';
import 'package:http/http.dart' as http;

//
// class ApiService {
//
//   static const String apiUrl = 'https://support.aquachemie.com/api/user-details/125'; // Replace with your API URL
//
//   Future<UserResponse> fetchUser() async {
//
//     final response = await http.get(Uri.parse(apiUrl));
//
//     if (response.statusCode == 200) {
//       return UserResponse.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load user data');
//     }
//   }
// }


import 'dart:convert';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:aquachemicals/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, dynamic>> fetchprofile();
}

class ProfileDataSourceImpl implements ProfileRepository {
  Future<int> _getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id') ?? 0;
  }

  @override
  Future<Either<Failure, UserResponse>> fetchprofile() async {
    try {
      final id = await _getId();
      print(id);
      final response = await http.get(
          Uri.parse("https://support.aquachemie.com/api/user-details/$id"));
      if (response.statusCode == 200) {
        print("${response.body}");
        var jsonResponse = UserResponse.fromJson(json.decode(response.body));
        return Right(jsonResponse);
      } else {
        return Left(Failure(statusCode: response.statusCode,
            message: 'Failed to fetch duty data'));
      }
    } catch (e) {
      return Left(Failure(statusCode: 500, message: 'Error occurred: $e'));
    }
  }
}