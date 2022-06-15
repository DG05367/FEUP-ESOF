import 'package:uni/model/entities/class_info.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/controller/schedule_fetcher/schedule_fetcher.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/lecture_profs.dart';
import 'package:uni/model/entities/personal_schedule_struct.dart';

import 'dart:convert';

import 'package:uni/model/entities/teacher_info.dart';
import 'package:redux/redux.dart';

Future<PersonalScheduleStruct> fetchClasses(store) async {
  final Dates dates = getDates();

  final List<Course> courses = store.state.content['profile'].courses;

  final List<Response> response2 =
      await Future.wait(courses.map((course) => NetworkRouter.getWithCookies(
          NetworkRouter.getBaseUrlFromSession(store.state.content['session']) +
              '''
mob_hor_geral.estudante?pv_codigo=${store.state.content['session'].studentNumber}&pv_semana_ini=${dates.beginWeek}&pv_semana_fim=${dates.endWeek}''',
          {},
          store.state.content['session'])));

  final responseJson = jsonDecode(response2[1].body);

  PersonalScheduleStruct res = PersonalScheduleStruct([], [], [], [], []);

  for (var lecture in responseJson['horario']) {
    res.addTo(
        lecture['dia'],
        ClassInfo(
          lecture['dia'],
          lecture['ucurr_sigla'],
          lecture['turma_sigla'],
          lecture['doc_sigla'],
          lecture['sala_sigla'],
          lecture['tipo'],
          lecture['ocorrencia_id'],
          lecture['aula_id'],
          lecture['aula_duracao'],
          lecture['hora_inicio'],
        ));
  }

  return res;
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
