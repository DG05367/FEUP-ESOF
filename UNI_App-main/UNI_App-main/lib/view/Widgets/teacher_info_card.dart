import 'package:flutter/material.dart';
import 'package:uni/view/Pages/teacher_schedule_ui.dart';

class TeacherCard extends StatelessWidget {
  final String teacherCode;
  final String teacherName;
  final String teacherInitials;
  final String teacherMail;
  final double borderRadius = 8.0;
  TeacherCard({
    Key key,
    @required this.teacherCode,
    @required this.teacherName,
    @required this.teacherInitials,
    @required this.teacherMail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0)),
                Flexible(
                  child: Text(
                    '${teacherName}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(fontSizeDelta: 6, fontWeightDelta: 1),
                  ),
                ),
              ]),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Sigla: ${teacherInitials}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(fontSizeDelta: 6, fontWeightDelta: 1),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                    primary: Colors.white),
                child: SizedBox(
                  width: queryData.size.width * 0.3,
                  child: const Text(
                    'Ver Horário',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherScheduleView(
                      teacherName: this.teacherName,
                      teacherCode: this.teacherCode,
                      teacherInitials: this.teacherInitials,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.mail,
                color: Colors.black,
                size: 24.0,
                semanticLabel: 'mail icon',
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              Text(
                '${teacherMail}',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeDelta: 6, fontWeightDelta: 1),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Código: ${teacherCode}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeDelta: 6, fontWeightDelta: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
