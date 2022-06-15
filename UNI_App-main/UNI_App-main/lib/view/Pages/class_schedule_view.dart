import 'package:flutter/material.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/class_schedule_card.dart';
import 'package:uni/controller/class_schedule.dart';

class ClassScheduleView extends StatefulWidget {
  final String className;

  const ClassScheduleView({Key key, this.className}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ClassScheduleViewState(className: className);
}

class ClassScheduleViewState extends UnnamedPageView {
  String className;
  ClassScheduleViewState({Key key, this.className});

  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 0.05 * queryData.size.height)),
          Container(
            child: Text(
              (className != null) ? className : 'ERROR',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .apply(fontSizeDelta: 10, fontWeightDelta: 1),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 0.03 * queryData.size.height)),
          Expanded(
            child: createClassButtons(context, getClassSchedule(className)),
          )
        ]);
  }
}

Widget createClassButtons(context, classes) {
  final List<Widget> examCards = <Widget>[];
  for (int i = 0; i < classes.length; i++) {
    examCards.add(ClassScheduleCard(
      classDay: classes[i].getDayName(),
      classTime: classes[i].startTime,
      classProfs: classes[i].profs,
      classRoom: classes[i].room,
      classClass: classes[i].classNum,
    ));
  }
  return ListView(children: examCards);
}
