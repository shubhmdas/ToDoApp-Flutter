import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
   const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),

      )
    );
  }
}
