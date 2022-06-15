class LectureProfs {
  final int classId;
  final int disciplineId;
  final String classNumber;
  final List<String> teacherCodes;

  LectureProfs({
    int this.classId,
    int this.disciplineId,
    String this.classNumber,
    List<String> this.teacherCodes,
  });

  /// Creates a new instance from a JSON object.
  static LectureProfs fromJson(dynamic data) {
    List<String> teachers2complete;

    for (var teacher in data['docentes']) {
      teachers2complete.add(teacher['doc_codigo']);
    }

    return LectureProfs(
      classId: data['cur_id'],
      disciplineId: data['fest_id'],
      classNumber: data['aula_id'],
      teacherCodes: teachers2complete,
    );
  }

  /// Converts this course to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': classId,
      'fest_id': disciplineId,
      'classNumber': classNumber,
      'currYear': teacherCodes,
    };
  }
}
