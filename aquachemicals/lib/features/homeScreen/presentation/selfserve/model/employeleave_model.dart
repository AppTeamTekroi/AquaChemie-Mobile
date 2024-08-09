class EmployeeLeave {
  final int id;
  final String? employeeId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? typeOfLeave;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeLeave({
    required this.id,
    this.employeeId,
    this.startDate,
    this.endDate,
    this.typeOfLeave,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeLeave.fromJson(Map<String, dynamic> json) {
    return EmployeeLeave(
      id: json['id'],
      employeeId: json['employee_id'],
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      typeOfLeave: json['type_of_leave'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'type_of_leave': typeOfLeave,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class EmployeeLeaveList {
  final bool success;
  final List<EmployeeLeave> employeeLeaves;
  final String message;

  EmployeeLeaveList({
    required this.success,
    required this.employeeLeaves,
    required this.message,
  });

  factory EmployeeLeaveList.fromJson(Map<String, dynamic> json) {
    var list = json['EmployeeLeaves'] as List;
    List<EmployeeLeave> employeeLeavesList = list.map((i) => EmployeeLeave.fromJson(i)).toList();

    return EmployeeLeaveList(
      success: json['success'],
      employeeLeaves: employeeLeavesList,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'EmployeeLeaves': employeeLeaves.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}