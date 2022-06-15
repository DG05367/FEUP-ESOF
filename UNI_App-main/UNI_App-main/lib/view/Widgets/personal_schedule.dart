import 'package:flutter/material.dart';
import 'package:uni/controller/personal_schedule.dart';
import 'package:uni/model/entities/class_info.dart';
import 'package:uni/view/Pages/personal_schedule_alternatives.dart';
import 'package:uni/view/Pages/personal_schedule_view.dart';

class PersonalScheduleCard extends StatelessWidget {
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
  final bool replaceable;
  final double borderRadius = 8.0;
  PersonalScheduleCard({
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
    @required this.replaceable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => {
        if (replaceable)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalScheduleAlternativesListView(
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
              ),
            ),
          ),
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(196, 196, 196, 1)),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${this.startTime}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${this.endTime}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ), //para o nome da cadeira e o tipo
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${this.className}',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(fontSizeDelta: 3),
                      ),
                      Text(
                        '(${this.type})',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(fontSizeDelta: -4),
                      ),
                    ],
                  ),
                  Text(
                    '${this.profs}|${this.classNum}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${this.room}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

class PersonalScheduleCardAlternative extends StatelessWidget {
  final List<ClassInfo> overlaps;
  final int aulaIdToReplace;
  final int aulaDayToReplace;
  final ClassInfo replaceableClass;
  final double borderRadius = 8.0;
  PersonalScheduleCardAlternative({
    Key key,
    @required this.overlaps,
    @required this.aulaDayToReplace,
    @required this.aulaIdToReplace,
    @required this.replaceableClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersonalSchedule schedule = PersonalSchedule();
    final MediaQueryData queryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        if (overlaps.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Conflitos no teu horário',
                    textAlign: TextAlign.center,
                  ),
                  content:
                      setupAlertDialoadContainer(context, queryData, overlaps),
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Queres trocar?',
                    textAlign: TextAlign.center,
                  ),
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              schedule.replaceClass(replaceableClass,
                                  aulaDayToReplace, aulaIdToReplace);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PersonalScheduleView()));
                            },
                            child: Text('Alterar')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancelar')),
                      ]),
                );
              });
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(196, 196, 196, 1)),
            child: Column(children: [
              Text(
                '${replaceableClass.getDayName()}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(fontSizeDelta: 1, fontWeightDelta: 0),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${replaceableClass.startTime}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(fontSizeDelta: -4),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${replaceableClass.endTime}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(fontSizeDelta: -4),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ), //para o nome da cadeira e o tipo
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${replaceableClass.className}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .apply(fontSizeDelta: 3),
                            ),
                            Text(
                              '(${replaceableClass.type})',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .apply(fontSizeDelta: -4),
                            ),
                          ],
                        ),
                        Text(
                          '${replaceableClass.profs}|${replaceableClass.classNum}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(fontSizeDelta: -4),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${replaceableClass.room}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(fontSizeDelta: -4),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ]),
            ]),
          ),
          (overlaps.isNotEmpty)
              ? Positioned(
                  right: 10.0,
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(140, 45, 25, 1),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: Center(
                        child: Text(
                          overlaps.length.toString() ?? '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

Widget setupAlertDialoadContainer(
    context, queryData, List<ClassInfo> overlaps) {
  return Container(
    height: queryData.size.height * 0.2, // Change as per your requirement
    width: queryData.size.height * 0.6, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: overlaps.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createScheduleOverlapCard(context, overlaps[index]),
        );
      },
    ),
  );
}

List<Widget> createScheduleOverlapCard(context, ClassInfo overlap) {
  return [
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${overlap.startTime}',
          style: Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
          textAlign: TextAlign.center,
        ),
        Text(
          '${overlap.endTime}',
          style: Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
          textAlign: TextAlign.center,
        ),
      ],
    ), //para o nome da cadeira e o tipo
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${overlap.className}',
              style:
                  Theme.of(context).textTheme.headline3.apply(fontSizeDelta: 3),
            ),
            Text(
              '(${overlap.type})',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .apply(fontSizeDelta: -4),
            ),
          ],
        ),
        Text(
          '${overlap.profs}|${overlap.classNum}',
          style: Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
          textAlign: TextAlign.center,
        ),
      ],
    ),

    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${overlap.room}',
          style: Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ];
}
