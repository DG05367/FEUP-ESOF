import 'package:flutter/material.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/view/Widgets/class_card.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/controller/class_schedule.dart';

class ClassScheduleListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClassScheduleListViewState();
}

/// Manages the 'about' section of the app.
class ClassScheduleListViewState extends GeneralPageViewState {
  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 12.0),
          child: PageTitle(name: 'Disciplinas'),
        ),
        Expanded(
          child: createClassButtons(context, getClassScheduleList()),
        )
      ],
    );
  }
}

Widget createClassButtons(context, classes) {
  final List<Widget> examCards = <Widget>[];
  for (int i = 0; i < classes.length; i++) {
    examCards.add(ClassCard(className: classes[i]));
  }
  return ListView(children: examCards);
}
