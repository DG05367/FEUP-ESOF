import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/controller/parsers/prof_info_parser.dart';
import 'package:uni/controller/schedule_fetcher/schedule_fetcher.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/lecture_profs.dart';

import 'dart:convert';

import 'package:uni/model/entities/teacher_info.dart';
import 'package:redux/redux.dart';

Future<List<ClassInfo>> fetchTeacherClassesInfo(
    Store<AppState> store, String teacherCode) async {
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
mob_hor_geral.docente?pv_codigo=${teacherCode}&pv_semana_ini=${dates.beginWeek}&pv_semana_fim=${dates.endWeek}''',
          {},
          store.state.content['session'])));

  final responseJson = jsonDecode(response2[1].body);

  final List<ClassInfo> teacherClasses = [];

  for (var aula in responseJson['horario']) {
    teacherClasses.add(ClassInfo(
      aula['dia'],
      aula['ucurr_sigla'],
      aula['turma_sigla'],
      aula['doc_sigla'],
      aula['sala_sigla'],
      aula['tipo'],
      aula['ocorrencia_id'],
      aula['aula_id'],
      aula['aula_duracao'],
      aula['hora_inicio'],
    ));
  }

  return teacherClasses;
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
