import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/row_container.dart';
import 'package:uni/view/Widgets/teacher_info_card.dart';
import 'package:uni/view/Widgets/teacher_info_list.dart';

class ScheduleSlot extends StatelessWidget {
  final String subject;
  final String rooms;
  final String begin;
  final String end;
  final String teacher;
  final String typeClass;
  final String classNumber;
  final int day;
  final int startTimeSeconds;

  ScheduleSlot(
      {Key key,
      @required this.subject,
      @required this.typeClass,
      @required this.rooms,
      @required this.begin,
      @required this.end,
      this.teacher,
      this.classNumber,
      @required this.day,
      @required this.startTimeSeconds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowContainer(
        child: Container(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 22.0, right: 22.0),
      child: createScheduleSlotRow(context),
    ));
  }

  Widget createScheduleSlotRow(context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return InkWell(
        onTap: () => showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (
              BuildContext context,
            ) {
              return Container(
                height: queryData.size.height * 0.8,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: queryData.size.width * 0.3,
                              child: createModalScheduleSlotTime(context),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  createTextField(
                                      this.subject,
                                      Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .apply(
                                            fontSizeDelta: 2,
                                            color: Colors.black,
                                          ),
                                      TextAlign.center),
                                  createTextField(
                                      this.typeClass,
                                      Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .apply(
                                            fontSizeDelta: 4,
                                            color: Colors.black,
                                          ),
                                      TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: queryData.size.width * 0.3,
                              child: createModalScheduleSlotRoomClass(context),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                              width: 2.0,
                              color: Colors.black,
                            )),
                            child: SizedBox(
                              width: queryData.size.width * 0.35,
                              child: const Text(
                                'Ver Alternativas',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                              width: 2.0,
                              color: Colors.black,
                            )),
                            child: SizedBox(
                              width: queryData.size.width * 0.35,
                              child: const Text(
                                'Direções',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                      SizedBox(
                        width: queryData.size.width,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 2.0,
                                color: Colors.black,
                              )),
                            ),
                            child: Text(
                              'Professores',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.headline3.apply(
                                        fontSizeDelta: 4,
                                        color: Colors.black,
                                      ),
                            )),
                      ),
                      Expanded(child: createClassButtons(context)),
                    ],
                  ),
                ),
              );
            }),
        child: Container(
            key: Key('schedule-slot-time-${this.begin}-${this.end}'),
            margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: createScheduleSlotPrimInfo(context),
            )));
  }

  Widget createScheduleSlotTime(context) {
    return Column(
      key: Key('schedule-slot-time-${this.begin}-${this.end}'),
      children: <Widget>[
        createScheduleTime(this.begin, context),
        createScheduleTime(this.end, context)
      ],
    );
  }

  Widget createModalScheduleSlotTime(context) {
    return Column(
      key: Key('schedule-modal-slot-time-${this.begin}-${this.end}'),
      children: <Widget>[
        createModalScheduleInfo(this.begin, context),
        createModalScheduleInfo('|', context),
        createModalScheduleInfo(this.end, context)
      ],
    );
  }

  Widget createModalScheduleSlotRoomClass(context) {
    return Column(
      key: Key(
          'schedule-modal-slot-room-class-${this.rooms}-${this.classNumber}'),
      children: <Widget>[
        createModalScheduleInfo(
            (this.rooms != null) ? this.rooms : '', context),
        createModalScheduleInfo('|', context),
        createModalScheduleInfo(
            (this.classNumber != null) ? this.classNumber : '', context)
      ],
    );
  }

  Widget createModalScheduleInfo(String time, context) => createTextField(
      time,
      Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -2),
      TextAlign.center);

  Widget createScheduleTime(String time, context) => createTextField(
      time,
      Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
      TextAlign.center);

  List<Widget> createScheduleSlotPrimInfo(context) {
    final subjectTextField = createTextField(
        this.subject,
        Theme.of(context).textTheme.headline3.apply(fontSizeDelta: 5),
        TextAlign.center);
    final typeClassTextField = createTextField(
        ' (' + this.typeClass + ')',
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);
    final roomTextField = createTextField(
        this.rooms,
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.right);
    return [
      createScheduleSlotTime(context),
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              subjectTextField,
              typeClassTextField,
            ],
          ),
          Row(
            children: [
              createScheduleSlotTeacherInfo(context),
              createScheduleSlotClass(context)
            ],
          )
        ],
      ),
      createScheduleSlotPrimInfoColumn(roomTextField)
    ];
  }

  Widget createScheduleSlotTeacherInfo(context) {
    return createTextField(
        this.teacher,
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);
  }

  Widget createScheduleSlotClass(context) {
    final classText =
        this.classNumber != null ? (' | ' + this.classNumber) : '';
    return createTextField(
        classText,
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);
  }

  Widget createTextField(text, style, alignment) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }

  Widget createScheduleSlotPrimInfoColumn(elements) {
    return Container(child: elements);
  }

  Widget createClassButtons(context) {
    return TeacherInfoList(
        classNumber: this.classNumber,
        day: this.day,
        subject: this.subject,
        begin: this.startTimeSeconds);
  }
}
