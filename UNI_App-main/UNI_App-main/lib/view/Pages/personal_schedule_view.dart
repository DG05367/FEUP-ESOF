import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/personal_schedule.dart';
import 'package:uni/controller/personal_schedule_fetcher.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/personal_schedule_struct.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/view/Widgets/class_schedule_card.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/view/Widgets/personal_schedule.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';

import '../Widgets/personal_schedule.dart';

class PersonalScheduleView extends StatefulWidget {
  const PersonalScheduleView({Key key}) : super(key: key);

  @override
  _PersonalScheduleViewState createState() => _PersonalScheduleViewState();
}

class _PersonalScheduleViewState extends GeneralPageViewState {
  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  PersonalSchedule schedule = PersonalSchedule();

  Future<PersonalScheduleStruct> futureScheduleInfo;

  @override
  Widget getBody(BuildContext context) {
    futureScheduleInfo = schedule.getClasses(context);

    final MediaQueryData queryData = MediaQuery.of(context);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<PersonalScheduleStruct>(
        future: futureScheduleInfo,
        builder: (BuildContext context,
            AsyncSnapshot<PersonalScheduleStruct> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children =
                List<Widget>.generate(snapshot.data.getDaySize(), (index) {
              return createScheduleColumn(
                  context, snapshot.data.getDay(index), index);
            });
          } else if (snapshot.hasError) {
            children = List<Widget>.generate(5, (index) {
              return Flexible(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Não foi possível mostrar as aulas'),
                      )
                    ]),
              );
            });
          } else {
            children = List<Widget>.generate(5, (index) {
              return Flexible(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    ]),
              );
            });
          }
          /*return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ); */

          return DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).backgroundColor,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  tabs: [
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: queryData.size.width * 1 / 3,
                      child: Tab(
                          key: Key('personal-schedule-page-tab-0'),
                          text: daysOfTheWeek[0]),
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: queryData.size.width * 1 / 3,
                      child: Tab(
                          key: Key('personal-schedule-page-tab-1'),
                          text: daysOfTheWeek[1]),
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: queryData.size.width * 1 / 3,
                      child: Tab(
                          key: Key('personal-schedule-page-tab-2'),
                          text: daysOfTheWeek[2]),
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: queryData.size.width * 1 / 3,
                      child: Tab(
                          key: Key('personal-schedule-page-tab-3'),
                          text: daysOfTheWeek[3]),
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: queryData.size.width * 1 / 3,
                      child: Tab(
                          key: Key('personal-schedule-page-tab-4'),
                          text: daysOfTheWeek[4]),
                    ),
                  ],
                ),
                title: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    'Horário Pessoal',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(fontSizeDelta: 7),
                  ),
                ),
              ),
              body: TabBarView(
                children: children,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        'Como alterar o horário',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            .apply(fontSizeDelta: 2, fontWeightDelta: 1),
                      ),
                      content: Text(
                        'Pressiona e aguenta na aula que queres trocar',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .apply(fontSizeDelta: 1, fontWeightDelta: 0),
                      ),
                    ),
                  );
                },
                backgroundColor: Color.fromRGBO(140, 45, 25, 1),
                child: const Icon(Icons.question_mark),
              ),
            ),
          );
        },
      ),
    );
  }

  Container createScheduleColumn(context, dayClasses, day) {
    if (dayClasses.length == 0) {
      return Container(
          key: Key('personal-schedule-page-day-column-$day'),
          child: Column(mainAxisSize: MainAxisSize.min, children: []));
    }
    final List<Widget> tabBarViewContent = <Widget>[];
    for (int i = 0; i < dayClasses.length; i++) {
      tabBarViewContent.add(PersonalScheduleCard(
        classDay: dayClasses[i].day,
        className: dayClasses[i].className,
        startTime: dayClasses[i].startTime,
        endTime: dayClasses[i].endTime,
        profs: dayClasses[i].profs,
        room: dayClasses[i].room,
        classNum: dayClasses[i].classNum,
        type: dayClasses[i].type,
        occurId: dayClasses[i].occurId,
        aulaId: dayClasses[i].aulaId,
        replaceable: true,
      ));
    }
    return Container(
        key: Key('personal-schedule-page-day-column-$day'),
        child: Column(
            mainAxisSize: MainAxisSize.min, children: tabBarViewContent));
  }
}
