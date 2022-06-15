import 'package:flutter/material.dart';
import 'package:uni/view/Pages/class_schedule_view.dart';
import 'package:uni/view/Pages/teacher_schedule_ui.dart';

class ClassCard extends StatelessWidget {
  final String className;
  final double borderRadius = 8.0;
  ClassCard({
    Key key,
    @required this.className,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ClassScheduleView(className: this.className)),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
        padding: EdgeInsets.only(top: 16, bottom: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: Text(
          '${this.className}',
          style: Theme.of(context)
              .textTheme
              .headline6
              .apply(fontSizeDelta: 6, fontWeightDelta: 1),
        ),
      ),
    );
  }
}
