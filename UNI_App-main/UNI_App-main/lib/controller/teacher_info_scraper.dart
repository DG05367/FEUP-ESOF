import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/controller/parsers/prof_info_parser.dart';
import 'package:uni/controller/schedule_fetcher/schedule_fetcher.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/lecture_profs.dart';

import 'dart:convert';

import 'package:uni/model/entities/teacher_info.dart';
import 'package:redux/redux.dart';

Future<List<TeacherInfo>> fetchTeacherInfo(Store<AppState> store,
    String classNumber, int day, String subject, int begin) async {
  List<TeacherInfo> teacherList = [];

  final Dates dates = getDates();

  final List<Course> courses = store.state.content['profile'].courses;

  final List<Response> response1 =
      await Future.wait(courses.map((course) => NetworkRouter.getWithCookies(
          NetworkRouter.getBaseUrlFromSession(store.state.content['session']) +
              '''
hor_geral.estudantes_view?pv_fest_id=${course.festId}&pv_ano_lectivo=${dates.lectiveYear}&p_semana_inicio=${dates.beginWeek}&p_semana_fim=${dates.endWeek}''',
          {},
          store.state.content['session'])));

  final List<Response> response2 =
      await Future.wait(courses.map((course) => NetworkRouter.getWithCookies(
          NetworkRouter.getBaseUrlFromSession(store.state.content['session']) +
              '''
mob_hor_geral.estudante?pv_codigo=${store.state.content['session'].studentNumber}&pv_semana_ini=${dates.beginWeek}&pv_semana_fim=${dates.endWeek}''',
          {},
          store.state.content['session'])));

  final responseJson = jsonDecode(response2[1].body);

  final List<String> profs = [];

  for (var aula in responseJson['horario']) {
    if (aula['dia'] == (day + 2) &&
        aula['hora_inicio'] == begin &&
        aula['ucurr_sigla'] == subject &&
        aula['turma_sigla'] == classNumber) {
      for (var teacher in aula['docentes']) {
        profs.add(teacher['doc_codigo'].toString());
      }
    }
  }

  final List<TeacherInfo> teacherInformations = []; //getTeacherInfoFromHtml

  for (var teacher in profs) {
    final List<Response> lectureResponses = await Future.wait(courses.map(
        (course) => NetworkRouter.getWithCookies(
            NetworkRouter.getBaseUrlFromSession(
                    store.state.content['session']) +
                '''
func_geral.formview?p_codigo=${teacher}''',
            {},
            store.state.content['session'])));

    final TeacherInfo newTeacher =
        await getTeacherInfoFromHtml(lectureResponses[0], teacher);

    teacherInformations.add(newTeacher);
  }

  return teacherInformations;
}

Dates getDates() {
  var date = DateTime.now();

  final String beginWeek = date.year.toString().padLeft(4, '0') +
      date.month.toString().padLeft(2, '0') +
      date.day.toString().padLeft(2, '0');
  date = date.add(Duration(days: 6));

  final String endWeek = date.year.toString().padLeft(4, '0') +
      date.month.toString().padLeft(2, '0') +
      date.day.toString().padLeft(2, '0');

  final lectiveYear = date.month < 8 ? date.year - 1 : date.year;
  return Dates(beginWeek, endWeek, lectiveYear);
}
