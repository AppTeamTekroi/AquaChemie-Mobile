class EmployeeDuty {
  final bool success;
  final DutyDetails employeeDuty;
  final String message;

  EmployeeDuty({
    required this.success,
    required this.employeeDuty,
    required this.message,
  });

  factory EmployeeDuty.fromJson(Map<String, dynamic> json) {
    return EmployeeDuty(
      success: json['success'],
      employeeDuty: DutyDetails.fromJson(json['employee_duty']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'employee_duty': employeeDuty.toJson(),
      'message': message,
    };
  }
}

class DutyDetails {
  final String userId;
  final int employeeId;
  final String placeName;
  final String dateTime;
  final String reason;
  final String updatedAt;
  final String createdAt;
  final int id;

  DutyDetails({
    required this.userId,
    required this.employeeId,
    required this.placeName,
    required this.dateTime,
    required this.reason,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DutyDetails.fromJson(Map<String, dynamic> json) {
    return DutyDetails(
      userId: json['user_id'],
      employeeId: json['employee_id'],
      placeName: json['place_name'],
      dateTime: json['date_time'],
      reason: json['reason'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'employee_id': employeeId,
      'place_name': placeName,
      'date_time': dateTime,
      'reason': reason,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
