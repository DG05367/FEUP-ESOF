import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/teacher_classes_scraper.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:redux/redux.dart';
import 'package:uni/view/Widgets/class_schedule_card.dart';

class TeacherClassesList extends StatefulWidget {
  final String teacherCode;
  final double borderRadius = 8.0;
  TeacherClassesList({Key key, @required this.teacherCode}) : super(key: key);

  @override
  _TeacherClassesListState createState() => _TeacherClassesListState();
}

class _TeacherClassesListState extends State<TeacherClassesList> {
  final double borderRadius = 8.0;

  Future<List<ClassInfo>> futureTeacherClasses;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    futureTeacherClasses = fetchTeacherClassesInfo(store, widget.teacherCode);
    final MediaQueryData queryData = MediaQuery.of(context);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<ClassInfo>>(
        future:
            futureTeacherClasses, // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<ClassInfo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                child: ListView(
                  children: List<Widget>.generate(
                    snapshot.data.length,
                    (index) {
                      return Container(
                        child: ClassScheduleCardWithName(
                            classDay: snapshot.data[index].getDayName(),
                            classTime: snapshot.data[index].startTime,
                            classProfs: snapshot.data[index].profs,
                            classRoom: snapshot.data[index].room,
                            classClass: snapshot.data[index].classNum,
                            classUC: snapshot.data[index].className,
                            classType: snapshot.data[index].type),
                      );
                    },
                  ),
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Não foi possível mostrar as aulas.'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('A carregar aulas...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
