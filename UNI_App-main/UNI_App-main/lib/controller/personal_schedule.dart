import 'dart:io';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';
import 'package:uni/controller/class_fetcher.dart';
import 'package:uni/controller/personal_schedule_fetcher.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/model/entities/personal_schedule_struct.dart';
import 'package:uni/controller/local_storage/app_personal_schedule_database.dart';

class PersonalSchedule {
  static final PersonalSchedule _instance = PersonalSchedule._internal();

  factory PersonalSchedule() {
    return _instance;
  }

  PersonalSchedule._internal();

  PersonalScheduleStruct info = PersonalScheduleStruct([], [], [], [], []);
  bool classesLoaded = false;

  Future<PersonalScheduleStruct> getClasses(context) async {
    final store = StoreProvider.of<AppState>(context);
    if (classesLoaded) {
      return info;
    }

    // final bool hasNet = await hasNetwork();
    // if (classes.isEmpty) {
    //   classes = fetchClassesFromDatabase();
    //   //if (hasNet) classes = await fetchClasses(context, classes);
    //   if (hasNet && classes.isEmpty) {
    //     classes = await fetchClasses(context);
    //     //TODO:save to DB;
    //   }
    // }
    //return fetchClasses(context);

    info = await fetchClasses(store);
    classesLoaded = true;
    return info;
  }

  Future<List<ClassInfo>> fetchClassesFromDatabase() {
    final AppPersonalScheduleDatabase db = AppPersonalScheduleDatabase();
    final Future<List<ClassInfo>> lectures = db.classes();
    return lectures;
  }

  void saveNewLecturesToDB(List<ClassInfo> newLectures) {
    final AppPersonalScheduleDatabase db = AppPersonalScheduleDatabase();
    db.saveNewLectures(newLectures);
    return;
  }

  List<ClassInfo> getOverlaps(ClassInfo a, int except) {
    if (!classesLoaded) return [];
    if (info.getDay(a.day - 2).isEmpty) return [];
    final List<ClassInfo> res = [];
    final List<ClassInfo> classToCheck = info.getDay(a.day - 2);
    for (int i = 0; i < classToCheck.length; i++) {
      if (a.aulaId == except) continue;
      if (a.overlaps(classToCheck[i])) {
        res.add(classToCheck[i]);
      }
    }
    return res;
  }

  void replaceClass(ClassInfo replacement, int aulaDay, int aulaId) {
    final List<ClassInfo> classes_ = info.getDay(aulaDay - 2);
    for (int i = 0; i < classes_.length; i++) {
      if (classes_[i].aulaId == aulaId) {
        if (classes_[i].day == aulaDay) {
          classes_[i] = replacement;
          info.updateCheck();
        } else {
          classes_.remove(classes_[i]);
          info.getDay(replacement.day - 2).add(replacement);
          info.updateCheck();
        }

        return;
      }
    }
  }
}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
