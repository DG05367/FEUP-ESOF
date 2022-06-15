import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/teacher_info_scraper.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/teacher_info.dart';
import 'package:redux/redux.dart';
import 'package:uni/view/Widgets/teacher_info_card.dart';

class TeacherInfoList extends StatefulWidget {
  final String classNumber;
  final int day;
  final String subject;
  final int begin;
  final double borderRadius = 8.0;
  TeacherInfoList(
      {Key key,
      @required this.classNumber,
      @required this.day,
      @required this.subject,
      @required this.begin})
      : super(key: key);

  @override
  _TeacherInfoListState createState() => _TeacherInfoListState();
}

class _TeacherInfoListState extends State<TeacherInfoList> {
  final double borderRadius = 8.0;

  Future<List<TeacherInfo>> futureTeacherInfo;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    futureTeacherInfo = fetchTeacherInfo(
        store, widget.classNumber, widget.day, widget.subject, widget.begin);
    final MediaQueryData queryData = MediaQuery.of(context);

    //TeacherData teacherData = getTeacherData(teacherInitials);
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<TeacherInfo>>(
        future:
            futureTeacherInfo, // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<TeacherInfo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                child: ListView(
                  children: List<Widget>.generate(
                    snapshot.data.length,
                    (index) {
                      return Container(
                        child: TeacherCard(
                          teacherCode: snapshot.data[index].code,
                          teacherName: snapshot.data[index].fullName,
                          teacherInitials: snapshot.data[index].teacherInitials,
                          teacherMail: snapshot.data[index].email,
                        ),
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
                child: Text('Não foi possível mostrar os professores'),
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
                child: Text('A carregar professores...'),
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
    ;
  }
}
