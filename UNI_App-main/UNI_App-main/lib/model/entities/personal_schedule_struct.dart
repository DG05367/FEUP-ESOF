import 'package:uni/model/entities/class_info.dart';

class PersonalScheduleStruct {
  List<ClassInfo> mondayClasses;
  List<ClassInfo> tuesdayClasses;
  List<ClassInfo> wednesdayClasses;
  List<ClassInfo> thursdayClasses;
  List<ClassInfo> fridayClasses;

  PersonalScheduleStruct(
    this.mondayClasses,
    this.tuesdayClasses,
    this.wednesdayClasses,
    this.thursdayClasses,
    this.fridayClasses,
  ) {
    this.mondayClasses = mondayClasses;
    this.tuesdayClasses = tuesdayClasses;
    this.wednesdayClasses = wednesdayClasses;
    this.thursdayClasses = thursdayClasses;
    this.fridayClasses = fridayClasses;
  }

  addTo(int day, ClassInfo class2Add) {
    switch (day) {
      case 2:
        {
          mondayClasses.add(class2Add);
          break;
        }
      case 3:
        {
          tuesdayClasses.add(class2Add);
          break;
        }
      case 4:
        {
          wednesdayClasses.add(class2Add);
          break;
        }
      case 5:
        {
          thursdayClasses.add(class2Add);
          break;
        }
      case 6:
        {
          fridayClasses.add(class2Add);
          break;
        }
    }
  }

  int getDaySize() {
    return 5;
  }

  List<ClassInfo> getDay(int dayMinus2) {
    switch (dayMinus2) {
      case 0:
        {
          return mondayClasses;
        }
      case 1:
        {
          return tuesdayClasses;
        }
      case 2:
        {
          return wednesdayClasses;
        }
      case 3:
        {
          return thursdayClasses;
        }
      case 4:
        {
          return fridayClasses;
        }
    }
    return [];
  }

  void updateCheck() {
    final List<int> mondaysToRemove = [];
    for (int j = 0; j < mondayClasses.length; ++j) {
      if (mondayClasses[j].day - 2 != 0) {
        addTo(mondayClasses[j].day, mondayClasses[j]);
        mondaysToRemove.add(j);
      }
    }
    if (mondaysToRemove.isNotEmpty) {
      mondaysToRemove.sort();
      for (int k = mondaysToRemove.length - 1; k >= 0; k--) {
        mondayClasses.removeAt(mondaysToRemove[k]);
      }
    }
    final List<int> tuesdaysToRemove = [];
    for (int j = 0; j < tuesdayClasses.length; ++j) {
      if (tuesdayClasses[j].day - 2 != 1) {
        addTo(tuesdayClasses[j].day, tuesdayClasses[j]);
        tuesdaysToRemove.add(j);
      }
    }
    if (tuesdaysToRemove.isNotEmpty) {
      tuesdaysToRemove.sort();
      for (int k = tuesdaysToRemove.length - 1; k >= 0; k--) {
        tuesdayClasses.removeAt(tuesdaysToRemove[k]);
      }
    }
    final List<int> wednesdaysToRemove = [];
    for (int j = 0; j < wednesdayClasses.length; ++j) {
      if (wednesdayClasses[j].day - 2 != 2) {
        addTo(wednesdayClasses[j].day, wednesdayClasses[j]);
        wednesdaysToRemove.add(j);
      }
    }
    if (wednesdaysToRemove.isNotEmpty) {
      wednesdaysToRemove.sort();
      for (int k = wednesdaysToRemove.length - 1; k >= 0; k--) {
        wednesdayClasses.removeAt(wednesdaysToRemove[k]);
      }
    }
    final List<int> thursdaysToRemove = [];
    for (int j = 0; j < thursdayClasses.length; ++j) {
      if (thursdayClasses[j].day - 2 != 3) {
        addTo(thursdayClasses[j].day, thursdayClasses[j]);
        thursdaysToRemove.add(j);
      }
    }
    if (thursdaysToRemove.isNotEmpty) {
      thursdaysToRemove.sort();
      for (int k = thursdaysToRemove.length - 1; k >= 0; k--) {
        thursdayClasses.removeAt(thursdaysToRemove[k]);
      }
    }
    final List<int> fridaysToRemove = [];
    for (int j = 0; j < fridayClasses.length; ++j) {
      if (fridayClasses[j].day - 2 != 4) {
        addTo(fridayClasses[j].day, fridayClasses[j]);
        fridaysToRemove.add(j);
      }
    }
    if (fridaysToRemove.isNotEmpty) {
      fridaysToRemove.sort();
      for (int k = fridaysToRemove.length - 1; k >= 0; k--) {
        fridayClasses.removeAt(fridaysToRemove[k]);
      }
    }
    mondayClasses
        .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
    tuesdayClasses
        .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
    wednesdayClasses
        .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
    thursdayClasses
        .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
    fridayClasses
        .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
  }
}
