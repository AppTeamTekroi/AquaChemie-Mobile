class BusinessTravel {
  final bool success;
  final TravelDetails businessTravel;
  final String message;

  BusinessTravel({
    required this.success,
    required this.businessTravel,
    required this.message,
  });

  factory BusinessTravel.fromJson(Map<String, dynamic> json) {
    return BusinessTravel(
      success: json['success'],
      businessTravel: TravelDetails.fromJson(json['Business Travel']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'Business Travel': businessTravel.toJson(),
      'message': message,
    };
  }
}

class TravelDetails {
  final String userId;
  final String employeeId;
  final String placeOfVisit;
  final String purposeOfVisit;
  final String shortDescription;
  final String customerName;
  final int numberOfDays;
  final String startDate;
  final String endDate;
  final String updatedAt;
  final String createdAt;
  final int id;

  TravelDetails({
    required this.userId,
    required this.employeeId,
    required this.placeOfVisit,
    required this.purposeOfVisit,
    required this.shortDescription,
    required this.customerName,
    required this.numberOfDays,
    required this.startDate,
    required this.endDate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory TravelDetails.fromJson(Map<String, dynamic> json) {
    return TravelDetails(
      userId: json['user_id'],
      employeeId: json['employee_id'],
      placeOfVisit: json['place_of_visit'],
      purposeOfVisit: json['purpose_of_visit'],
      shortDescription: json['short_description'],
      customerName: json['customer_name'],
      numberOfDays: json['number_of_days'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'employee_id': employeeId,
      'place_of_visit': placeOfVisit,
      'purpose_of_visit': purposeOfVisit,
      'short_description': shortDescription,
      'customer_name': customerName,
      'number_of_days': numberOfDays,
      'start_date': startDate,
      'end_date': endDate,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
