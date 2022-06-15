import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/class_fetcher.dart';
import 'package:uni/controller/personal_schedule.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/class_schedule_card.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/controller/class_schedule.dart';
import 'package:uni/view/Widgets/personal_schedule.dart';

class PersonalScheduleAlternativesListView extends StatefulWidget {
  final int classDay;
  final String className;
  final String startTime;
  final String endTime;
  final String profs;
  final String room;
  final String classNum;
  final String type;
  final int occurId;
  final int aulaId;
  PersonalScheduleAlternativesListView({
    Key key,
    @required this.classDay,
    @required this.className,
    @required this.startTime,
    @required this.endTime,
    @required this.profs,
    @required this.room,
    @required this.classNum,
    @required this.type,
    @required this.occurId,
    @required this.aulaId,
  }) : super(key: key);
  //TODO: Add class to replace info.
  @override
  State<StatefulWidget> createState() =>
      PersonalScheduleAlternativesListViewState(
        classDay: this.classDay,
        className: this.className,
        startTime: this.startTime,
        endTime: this.endTime,
        profs: this.profs,
        room: this.room,
        classNum: this.classNum,
        type: this.type,
        occurId: this.occurId,
        aulaId: this.aulaId,
      );
}

class PersonalScheduleAlternativesListViewState extends UnnamedPageView {
  final int classDay;
  final String className;
  final String startTime;
  final String endTime;
  final String profs;
  final String room;
  final String classNum;
  final String type;
  final int occurId;
  final int aulaId;
  PersonalScheduleAlternativesListViewState({
    @required this.classDay,
    @required this.className,
    @required this.startTime,
    @required this.endTime,
    @required this.profs,
    @required this.room,
    @required this.classNum,
    @required this.type,
    @required this.occurId,
    @required this.aulaId,
  });

  Future<List<ClassInfo>> futureScheduleInfo;

  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  @override
  Widget getBody(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    futureScheduleInfo = fetchClassLectures(store, occurId, aulaId, type);

    final MediaQueryData queryData = MediaQuery.of(context);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<ClassInfo>>(
        future: futureScheduleInfo,
        builder:
            (BuildContext context, AsyncSnapshot<List<ClassInfo>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = createClassButtons(
                context, snapshot.data, this.classDay, this.aulaId);
          } else if (snapshot.hasError) {
            children =
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Não foi possível mostrar as aulas'),
              )
            ]);
          } else {
            children =
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                key: Key('personal_schedule_loading_indicator'),
                padding: EdgeInsets.only(top: 16),
                child: Text('A carregar aulas...'),
              )
            ]);
          }
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Column(
                  children: [
                    PageTitle(name: 'Aula para substituir'),
                    Text(
                      '${daysOfTheWeek[classDay - 2]}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .apply(fontSizeDelta: 1, fontWeightDelta: 0),
                    ),
                    PersonalScheduleCard(
                      classDay: classDay,
                      className: className,
                      startTime: startTime,
                      endTime: endTime,
                      profs: profs,
                      room: room,
                      classNum: classNum,
                      type: type,
                      occurId: occurId,
                      aulaId: aulaId,
                      replaceable: false,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: children,
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget createClassButtons(
    context, List<ClassInfo> classes, int aulaDay, int aulaId) {
  final PersonalSchedule schedule = PersonalSchedule();
  final List<Widget> resCards = <Widget>[];
  for (int i = 0; i < classes.length; i++) {
    final List<ClassInfo> overlaps = schedule.getOverlaps(classes[i], aulaId);
    resCards.add(PersonalScheduleCardAlternative(
      overlaps: overlaps,
      aulaDayToReplace: aulaDay,
      aulaIdToReplace: aulaId,
      replaceableClass: classes[i],
    ));
  }
  return ListView(children: resCards);
}
