import 'package:logger/logger.dart';

// ClassInfo
// Contains the information of a class.
class ClassInfo {
  static var dayName = {
    1: 'Domingo',
    2: 'Segunda-feira',
    3: 'Terça-feira',
    4: 'Quarta-feira',
    5: 'Quinta-feira',
    6: 'Sexta-feira',
    7: 'Sábado',
  };

  String className;
  String startTime;
  String endTime;
  String profs;
  String room;
  String classNum;
  String type;
  int day;
  int blocks;
  int occurId;
  int aulaId;
  int startTimeSeconds;

  ClassInfo(
      int day,
      String className,
      String classNum,
      String profs,
      String room,
      String type,
      int occurId,
      int aulaId,
      int blocks,
      int startTimeSeconds) {
    this.day = day;
    this.className = className;
    this.profs = profs;
    this.room = room;
    this.classNum = classNum;
    this.type = type;
    this.occurId = occurId;
    this.aulaId = aulaId;
    this.blocks = blocks;
    this.startTimeSeconds = startTimeSeconds;
    this.startTime = getStartTime(startTimeSeconds);
    this.endTime = getEndTime(blocks, startTimeSeconds);
  }

  String getStartTime(int startTimeSeconds) {
    final String startTime =
        (startTimeSeconds ~/ 3600).toString().padLeft(2, '0') +
            'h' +
            ((startTimeSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    return startTime;
  }

  String getEndTime(int blocks, int startTimeSeconds) {
    final String endTime = ((60 * 60 * blocks + startTimeSeconds) ~/ 3600)
            .toString()
            .padLeft(2, '0') +
        'h' +
        (((60 * 60 * blocks + startTimeSeconds) % 3600) ~/ 60)
            .toString()
            .padLeft(2, '0');
    return endTime;
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'className': className,
      'profs': profs,
      'room': room,
      'type': type,
      'occurId': occurId,
      'aulaId': aulaId,
      'blocks': blocks,
      'startTimeSeconds': startTimeSeconds
    };
  }

  String getDayName() {
    return dayName[this.day];
  }

  // Prints the data in this exam to the [Logger] with an INFO level.
  void printClassInfo() {
    Logger().i(
        '''$day - $className - $room - $classNum - $profs - $type  - $occurId - $aulaId - $blocks - $startTimeSeconds''');
  }

  @override
  String toString() {
    return '''$day - $className - $room - $classNum - $profs - $type - $occurId - $aulaId - $blocks - $startTimeSeconds''';
  }

  @override
  int get hashCode =>
      day.hashCode ^
      className.hashCode ^
      profs.hashCode ^
      room.hashCode ^
      classNum.hashCode ^
      type.hashCode ^
      occurId.hashCode ^
      aulaId.hashCode ^
      blocks.hashCode ^
      startTimeSeconds ^
      startTime.hashCode ^
      endTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassInfo &&
          runtimeType == other.runtimeType &&
          day == other.day &&
          className == other.className &&
          profs == other.profs &&
          room == other.room &&
          classNum == other.classNum &&
          type == other.type &&
          occurId == other.occurId &&
          aulaId == other.aulaId &&
          blocks == other.blocks &&
          startTimeSeconds == other.startTimeSeconds &&
          startTime == other.startTime &&
          endTime == other.endTime;

  bool overlaps(ClassInfo other) {
    if (this.day != other.day) {
      return false;
    }

    if ((this.startTimeSeconds + 3600 * this.blocks) <=
            other.startTimeSeconds ||
        (other.startTimeSeconds + 3600 * other.blocks) <=
            this.startTimeSeconds) {
      return false;
    }

    return true;
  }
}
