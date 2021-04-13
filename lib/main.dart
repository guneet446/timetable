import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timetable/Meeting.dart';
import 'package:timetable/MeetingDataSource.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

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
    setState(() {
      appointments.add(Meeting(
          from: date.add(const Duration(hours: 1)),
          to: date.add(const Duration(hours: 2)),
          title: 'Custom Meeting',
          isAllDay: false,
          background: Colors.blue,
          fromZone: '',
          toZone: '',
          recurrenceRule: '',
          exceptionDates: null
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  //List<Meeting> appointments = <Meeting>[];
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
