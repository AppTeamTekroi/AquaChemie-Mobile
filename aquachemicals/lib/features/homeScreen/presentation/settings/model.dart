import 'dart:convert';

class UserResponse {
  final bool success;
  final User user;
  final String message;

  UserResponse({
    required this.success,
    required this.user,
    required this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      user: User.fromJson(json['Users']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'Users': user.toJson(),
      'message': message,
    };
  }
}

class User {
  final int id;
  final String employeeId;
  final String name;
  final String email;
  final String? mobile;
  final String? emailVerifiedAt;
  final int role;
  final int status;
  final String? supportDomain;
  final String createdAt;
  final String? updatedAt;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String department;
  final String designation;
  final String reportingTo;
  final String headQuarter;
  final String region;
  final String joiningDate;
  final String employeer;
  final String employeeBloodGroup;
  final String? exitDate;
  final int exitStatus;

  User({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.email,
    this.mobile,
    this.emailVerifiedAt,
    required this.role,
    required this.status,
    this.supportDomain,
    required this.createdAt,
    this.updatedAt,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.department,
    required this.designation,
    required this.reportingTo,
    required this.headQuarter,
    required this.region,
    required this.joiningDate,
    required this.employeer,
    required this.employeeBloodGroup,
    this.exitDate,
    required this.exitStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      employeeId: json['employee_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      status: json['status'],
      supportDomain: json['support_domain'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      department: json['department'],
      designation: json['designation'],
      reportingTo: json['reporting_to'],
      headQuarter: json['head_quarter'],
      region: json['region'],
      joiningDate: json['joining_date'],
      employeer: json['employeer'],
      employeeBloodGroup: json['employee_blood_group'],
      exitDate: json['exit_date'],
      exitStatus: json['exit_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'status': status,
      'support_domain': supportDomain,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'department': department,
      'designation': designation,
      'reporting_to': reportingTo,
      'head_quarter': headQuarter,
      'region': region,
      'joining_date': joiningDate,
      'employeer': employeer,
      'employee_blood_group': employeeBloodGroup,
      'exit_date': exitDate,
      'exit_status': exitStatus,
    };
  }
}
