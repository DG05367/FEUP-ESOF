import 'package:flutter/material.dart';

class ClassScheduleCard extends StatelessWidget {
  final String classDay;
  final String classTime;
  final String classProfs;
  final String classRoom;
  final String classClass;
  final double borderRadius = 8.0;
  ClassScheduleCard({
    Key key,
    @required this.classDay,
    @required this.classTime,
    @required this.classProfs,
    @required this.classRoom,
    @required this.classClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(196, 196, 196, 1)),
          child: Column(children: [
            Text(
              '${this.classDay}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .apply(fontSizeDelta: 5, fontWeightDelta: 1),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${this.classTime}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: 2, fontWeightDelta: 0),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                Text(
                  '${this.classRoom}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: 2, fontWeightDelta: 0),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${this.classClass}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: 1, fontWeightDelta: 0),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                Text(
                  '${this.classProfs}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: 1, fontWeightDelta: 0),
                ),
              ],
            ),
          ])),
    );
  }
}

class ClassScheduleCardWithName extends StatelessWidget {
  final String classDay;
  final String classTime;
  final String classProfs;
  final String classRoom;
  final String classClass;
  final String classUC;
  final String classType;
  final double borderRadius = 8.0;
  ClassScheduleCardWithName({
    Key key,
    @required this.classDay,
    @required this.classTime,
    @required this.classProfs,
    @required this.classRoom,
    @required this.classClass,
    @required this.classUC,
    @required this.classType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(196, 196, 196, 1)),
        child: Column(children: [
          Text(
            '${this.classDay}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .apply(fontSizeDelta: 5, fontWeightDelta: 1),
          ),
          Padding(padding: EdgeInsets.all(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${this.classTime}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(fontSizeDelta: 2, fontWeightDelta: 0),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              Text(
                '${this.classRoom}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(fontSizeDelta: 2, fontWeightDelta: 0),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${this.classClass}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(fontSizeDelta: 1, fontWeightDelta: 0),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              Text(
                '${this.classProfs}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(fontSizeDelta: 1, fontWeightDelta: 0),
              ),
            ],
          ), //para o nome da cadeira e o tipo
          Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${this.classUC}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(fontSizeDelta: 4, fontWeightDelta: 0),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              Text(
                '(${this.classType})',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(fontSizeDelta: -1, fontWeightDelta: 0),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
