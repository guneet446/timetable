import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Meeting.dart';
import 'MeetingDataSource.dart';

List<Meeting> appointments = <Meeting>[];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  createMeeting() {
    print('pressed');
    /*setState(() {
      appointments.add(Meeting(
          from: date.subtract(const Duration(hours: 2)),
          to: date.subtract(const Duration(hours: 1)),
          title: 'Custom Meeting',
          isAllDay: false,
          background: Colors.blue,
          fromZone: '',
          toZone: '',
          recurrenceRule: '',
          exceptionDates: null
      ));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable"),
        actions: [
          PopupMenuButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 7.0, right: 25.0),
                  child: Text(
                      "+",
                  style: TextStyle(fontSize: 34),),
                ),
                itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Weekly Class"),
                  ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Extra Class"),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text("Meeting"),
                  ),
                ],
                onCanceled: () {
                print("You have canceled the call");
                },
                onSelected: (value) {
                  if (value == 1) {
                    appointments.add(Meeting(
                        from: date,
                        to: date.add(const Duration(hours: 1)),
                        title: 'General Meeting',
                        isAllDay: false,
                        background: Colors.red,
                        fromZone: '',
                        toZone: '',
                        recurrenceRule: '',
                        exceptionDates: null
                    ));
                  }
                  else if (value == 2)
                    number = '100';
                  else if (value == 3)
                    number = '101';
                  _service.call(number);
                },
              ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        dataSource: _getCalendarDataSource(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createMeeting,
      ),
    );
  }
}

DateTime date = DateTime.now();
MeetingDataSource _getCalendarDataSource() {
  appointments.add(Meeting(
      from: date,
      to: date.add(const Duration(hours: 1)),
      title: 'General Meeting',
      isAllDay: false,
      background: Colors.red,
      fromZone: '',
      toZone: '',
      recurrenceRule: '',
      exceptionDates: null
  ));

  return MeetingDataSource(appointments);
}
