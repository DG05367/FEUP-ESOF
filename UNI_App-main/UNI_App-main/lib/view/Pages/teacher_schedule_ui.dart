import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/class_schedule_card.dart';
import 'package:uni/controller/class_schedule.dart';
import 'package:uni/view/Widgets/teacher_class_list.dart';

class TeacherScheduleView extends StatefulWidget {
  final String teacherName;
  final String teacherCode;
  final String teacherInitials;

  const TeacherScheduleView(
      {Key key, this.teacherName, this.teacherCode, this.teacherInitials})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TeacherScheduleViewState(
      teacherName: this.teacherName,
      teacherCode: teacherCode,
      teacherInitials: teacherInitials);
}

class TeacherScheduleViewState extends UnnamedPageView {
  final String teacherName;
  final String teacherCode;
  final String teacherInitials;
  TeacherScheduleViewState(
      {Key key, this.teacherName, this.teacherCode, this.teacherInitials});

  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 0.05 * queryData.size.height)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0.03 * queryData.size.width),
              ),
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    child: Image.network(
                      'https://sigarra.up.pt/feup/pt/fotografias_service.foto?pct_cod=${teacherCode}',
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image.asset(
                            'assets/images/profile_placeholder.png');
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      (teacherName != null) ? teacherName : 'ERROR',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .apply(fontSizeDelta: 10, fontWeightDelta: 1),
                    ),
                    Text(
                      (teacherInitials != null) ? teacherInitials : 'ERROR',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .apply(fontSizeDelta: 10, fontWeightDelta: 1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0.03 * queryData.size.width),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 0.03 * queryData.size.height)),
        Expanded(child: createClassCards(context, this.teacherCode)),
      ],
    );
  }
}

Widget createClassCards(context, teacherCode_) {
  return TeacherClassesList(teacherCode: teacherCode_);
}
