import 'package:logger/logger.dart';

/// ClassInfo
/// Containes the information of a class.
class TeacherInfo {
  String teacherInitials;
  String fullName;
  String code;
  String email;

  TeacherInfo(
      String teacherInitials, String fullName, String code, String email) {
    this.teacherInitials = teacherInitials;
    this.fullName = fullName;
    this.code = code;
    this.email = email;
  }

  Map<String, dynamic> toMap() {
    return {
      'initials': teacherInitials,
      'fullName': fullName,
      'code': code,
      'email': email,
    };
  }

  void printExam() {
    Logger().i('''$teacherInitials - $fullName - $code - $email''');
  }

  @override
  String toString() {
    return '''$teacherInitials - $fullName - $code - $email''';
  }

  @override
  int get hashCode =>
      teacherInitials.hashCode ^
      fullName.hashCode ^
      code.hashCode ^
      email.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherInfo &&
          runtimeType == other.runtimeType &&
          teacherInitials == other.teacherInitials &&
          fullName == other.fullName &&
          code == other.code &&
          email == other.email;
}
