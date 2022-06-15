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
import 'package:uni/model/entities/personal_schedule_struct.dart';

Future<List<ClassInfo>> fetchClassLectures(
    store, ocurrId, aulaId, aulaTipo) async {
  final Dates dates = getDates();

  final List<Course> courses = store.state.content['profile'].courses;

  final List<Response> response2 = await Future.wait(courses.map((course) =>
      NetworkRouter.getWithCookies(
          NetworkRouter.getBaseUrlFromSession(store.state.content['session']) +
              '''
mob_hor_geral.ucurr?pv_ocorrencia_id=${ocurrId}&pv_semana_ini=${dates.beginWeek}&pv_semana_fim=${dates.endWeek}''',
          {},
          store.state.content['session'])));

  final responseJson = jsonDecode(response2[1].body);

  List<ClassInfo> res = [];

  for (var lecture in responseJson['horario']) {
    if (lecture['aula_id'] == aulaId) continue;
    if (lecture['tipo'] != aulaTipo) continue;
    res.add(
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
      ),
    );
  }

  res.sort((a, b) {
    return (a.day > b.day) ? 1 : 0;
  });

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
