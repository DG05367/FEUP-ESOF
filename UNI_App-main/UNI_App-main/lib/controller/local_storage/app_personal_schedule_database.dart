import 'dart:async';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:sqflite/sqflite.dart';

/// Manages the app's Personalized Schedule database.
///
/// This database stores information about the user's schedule change.
/// See the [ClassInfo] class to see what data is stored in this database.
class AppPersonalScheduleDatabase extends AppDatabase {
  static final createScript = '''CREATE TABLE classes(day INTEGER,
        className TEXT, profs TEXT, room TEXT, classNum TEXT, type TEXT, occurId INTEGER, aulaId INTEGER, blocks INTEGER, startTimeSeconds INTEGER)''';
  static final updateClassNum = '''ALTER TABLE classes ADD classNum TEXT''';

  AppPersonalScheduleDatabase()
      : super(
            'classes.db',
            [
              createScript,
            ],
            onUpgrade: migrate,
            version: 3);

  /// Replaces all of the data in this database with [lecs].
  saveNewLectures(List<ClassInfo> lecs) async {
    await deleteLectures();
    await _insertLectures(lecs);
  }

  /// Returns a list containing all of the lectures stored in this database.
  Future<List<ClassInfo>> classes() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    // Query the table for All The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('classes');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ClassInfo(
        maps[i]['day'],
        maps[i]['className'],
        maps[i]['profs'],
        maps[i]['room'],
        maps[i]['classNum'],
        maps[i]['type'],
        maps[i]['occurId'],
        maps[i]['aulaId'],
        maps[i]['blocks'],
        maps[i]['startTimeSeconds'],
      );
    });
  }

  /// Adds all items from [lecs] to this database.
  ///
  /// If a row with the same data is present, it will be replaced.
  Future<void> _insertLectures(List<ClassInfo> lecs) async {
    for (ClassInfo lec in lecs) {
      await this.insertInDatabase(
        'classes',
        lec.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Updates the row [aulaId] from the Table [classes]
  ///  with the new lecture [values]
  Future<void> updateLectures(
      Map<String, dynamic> values, String oldAulaId) async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.update('classes', values, where: 'classNum = ' + oldAulaId);
  }

  /// Deletes all of the data stored in this database.
  Future<void> deleteLectures() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.delete('classes');
  }

  /// Migrates [db] from [oldVersion] to [newVersion].
  ///
  /// *Note:* This operation only updates the schema of the tables present in
  /// the database and, as such, all data is lost.
  static FutureOr<void> migrate(
      Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    if (oldVersion == 1) {
      batch.execute('DROP TABLE IF EXISTS classes');
      batch.execute(createScript);
    } else if (oldVersion == 2) {
      batch.execute(updateClassNum);
    }
    await batch.commit();
  }
}
