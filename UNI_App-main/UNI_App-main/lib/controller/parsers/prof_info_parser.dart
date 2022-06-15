import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/teacher_info.dart';

/// Extracts the user's lectures from an HTTP [response] and sorts them by date.
///
/// This function parses the schedule's HTML page.
Future<TeacherInfo> getTeacherInfoFromHtml(
    http.Response response, String teacherCode) async {
  final document = parse(response.body);
  //print(document.body);
  // var semana = [0, 0, 0, 0, 0, 0];

  // final List<Lecture> lecturesList = [];
  // document.querySelectorAll('.horario > tbody > tr').forEach((Element element) {
  //   if (element.getElementsByClassName('horas').isNotEmpty) {
  //     var day = 0;
  //     final List<Element> children = element.children;
  //     for (var i = 1; i < children.length; i++) {
  //       for (var d = day; d < semana.length; d++) {
  //         if (semana[d] == 0) {
  //           break;
  //         }
  //         day++;
  //       }
  //       final clsName = children[i].className;
  //       if (clsName == 'TE' || clsName == 'TP' || clsName == 'PL') {
  //         final String subject =
  //             children[i].querySelector('b > acronym > a').text;
  //         String classNumber = null;

  //         if (clsName == 'TP' || clsName == 'PL') {
  //           classNumber = children[i].querySelector('span > a').text;
  //         }

  //         final Element rowSmall =
  //             children[i].querySelector('table > tbody > tr');
  //         final String room = rowSmall.querySelector('td > a').text;
  //         final String teacher = rowSmall.querySelector('td.textod a').text;

  //         final String typeClass = clsName;
  //         final int blocks = int.parse(children[i].attributes['rowspan']);
  //         final String startTime = children[0].text.substring(0, 5);

  //         semana[day] += blocks;

  //         final Lecture lect = Lecture.fromHtml(subject, typeClass, day,
  //             startTime, blocks, room, teacher, classNumber);
  //         lecturesList.add(lect);
  //       }
  //       day++;
  //     }
  //     semana = semana.expand((i) => [(i - 1) < 0 ? 0 : i - 1]).toList();
  //   }
  // });
  // lecturesList.sort((a, b) => a.compare(b));
  String profName = 'a';
  String profInitials = 'b'; //!
  String profMail = 'd';
  document
      .querySelectorAll('.informacao-pessoal-dados-dados > table')
      .forEach((Element element) {
    if (element.className == 'tabelasz') {
      List<Element> infoPart = element.querySelectorAll('tbody > tr');
      infoPart[0].querySelectorAll('td').forEach((Element element) {
        if (element.className != 'formulario-legenda') {
          profName = element.text;
        }
      });

      infoPart[1].querySelectorAll('td').forEach((Element element) {
        if (element.className != 'formulario-legenda') {
          profInitials = element.text;
        }
      });
    } else {
      List<Element> mailPart = element.querySelectorAll('tbody > tr');
      mailPart[0].querySelectorAll('td').forEach((element) {
        if (element.className != 'formulario-legenda') {
          int start = element
              .querySelector('a')
              .attributes['onclick']
              .indexOf('\'ma\'+\'i\'+\'lto\'+\':');
          int end = element
              .querySelector('a')
              .attributes['onclick']
              .indexOf('\'+secure+\'');
          String mailFirstPart = (element
              .querySelector('a')
              .attributes['onclick']
              .substring(start + 17, end));
          String mailSecondPart = element
              .querySelector('a')
              .attributes['onclick']
              .substring(
                  end + 10,
                  (element.querySelector('a').attributes['onclick'].length -
                      1));
          profMail = mailFirstPart + '@' + mailSecondPart;
        }
      });
    }
  });
  return TeacherInfo(profInitials, profName, teacherCode, profMail);
}
