class BaseAttendanceDetailedModel {
  String name, phoneNumber;

  BaseAttendanceDetailedModel({required this.name, required this.phoneNumber});
}

class AttendanceDetailedModel {
  List<BaseAttendanceDetailedModel>? students = [];

  String? errorMsg;

  AttendanceDetailedModel.fromJson(Map<String, dynamic> json) {
    students = [];
    for (var student in json['data']) {
      students!.add(
        BaseAttendanceDetailedModel(
          name: student['student_name'],
          phoneNumber: student['phone_number'],
        ),
      );
    }
  }

  AttendanceDetailedModel.withError(String this.errorMsg);
}
