// import 'package:http/http.dart';
// import 'package:uni/controller/class_professor_fetcher/class_professor_fetcher.dart';
// import 'package:uni/controller/networking/network_router.dart';
// import 'package:uni/controller/parsers/parser_schedule_html.dart';
// import 'package:uni/model/app_state.dart';
// import 'package:uni/model/entities/course.dart';
// import 'package:uni/model/entities/lecture.dart';
// import 'package:redux/redux.dart';
// import 'package:uni/model/entities/teacher_info.dart';

// /// Class for fetching the user's lectures from the schedule's HTML page.
// class getClassProfessorsHtml extends ClassProfessorsFetcher {
//   //https://sigarra.up.pt/feup/pt/fest_geral.curso_percurso_academico_view?pv_fest_id=1313406 Ir buscar codigo aqui!
//   /// Fetches the user's lectures from the schedule's HTML page.
//   @override
//   Future<List<TeacherInfo>> getClassProfessors(Store<AppState> store) async {
//     final List<Course> courses = store.state.content['profile'].courses;
//     final List<Response> classesResponses = await Future.wait(courses.map(
//         (course) => NetworkRouter.getWithCookies(
//             NetworkRouter.getBaseUrlFromSession(
//                     store.state.content['session']) +
//                 '''
// hor_geral.estudantes_view?pv_fest_id=${course.festId}&pv_ano_lectivo=${dates.lectiveYear}&p_semana_inicio=${dates.beginWeek}&p_semana_fim=${dates.endWeek}''',
//             {},
//             store.state.content['session'])));

//     final List<TeacherInfo> classes = await Future.wait(classesResponses
//             .map((response) => getClassProfessorFromHtml(response)))
//         .then((classes) => classes.expand((class_) => class_).toList());

//     classes.sort((l1, l2) => l1.compare(l2));
//     return classes;
//   }
// }
