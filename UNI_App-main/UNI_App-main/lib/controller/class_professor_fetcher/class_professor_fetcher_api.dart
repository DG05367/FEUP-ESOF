// import 'package:uni/controller/networking/network_router.dart';
// import 'package:uni/controller/class_professor_fetcher/class_professor_fetcher.dart';
// import 'package:uni/controller/parsers/parser_class_professors.dart';
// import 'package:uni/model/app_state.dart';
// import 'package:redux/redux.dart';
// import 'package:uni/model/entities/teacher_info.dart';

// /// Class for fetching the user's lectures from the faculty's API.
// class ClassProfessorsFetcherApi extends ClassProfessorsFetcher {
//   /// Fetches the user's lectures from the faculty's API.
//   @override
//   Future<List<TeacherInfo>> getClassProfessors(Store<AppState> store) async {
//     final dates = getDates();
//     final List<TeacherInfo> teachers = await parseProfessors(
//         await NetworkRouter.getWithCookies(
//             NetworkRouter.getBaseUrlFromSession(
//                     store.state.content['session']) +
//                 //ignore: lines_longer_than_80_chars
//                 '''mob_hor_geral.estudante?pv_codigo=${store.state.content['session'].studentNumber}&pv_semana_ini=${dates.beginWeek}&pv_semana_fim=${dates.endWeek}''',
//             {},
//             store.state.content['session']));
//     return teachers;
//   }
// }
