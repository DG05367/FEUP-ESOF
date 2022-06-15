import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/lecture_profs.dart';

/// Extracts the user's lectures from an HTTP [response] and sorts them by date.
///
/// This function parses the schedule's HTML page.
Future<List<String>> getProfsFromHtml(
    http.Response response, String classNumber) async {
  final document = parse(response.body);
  var semana = [0, 0, 0, 0, 0, 0];

  final List<String> profCodesList = [];
  document.querySelectorAll('.horario > tbody > tr').forEach((Element element) {
    if (element.getElementsByClassName('horas').isNotEmpty) {
      var day = 0;
      final List<Element> children = element.children;
      for (var i = 1; i < children.length; i++) {
        for (var d = day; d < semana.length; d++) {
          if (semana[d] == 0) {
            break;
          }
          day++;
        }
        final clsName = children[i].className;
        if (clsName == 'TE' || clsName == 'TP' || clsName == 'PL') {
          final String subjectLink =
              children[i].querySelector('b > acronym > a').attributes['href'];

          profCodesList.add(classNumber);
        }
        day++;
      }
      semana = semana.expand((i) => [(i - 1) < 0 ? 0 : i - 1]).toList();
    }
  });

  return profCodesList;
}
