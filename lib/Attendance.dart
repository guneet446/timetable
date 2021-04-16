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

  double startHour = 7;
  double endHour = 20;
  DateTime date = DateTime.now();
  DateTime now = new DateTime.now();
  TimeOfDay initial = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay from = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay till = TimeOfDay(hour: 0, minute: 0);
  DateTime from_dt;
  DateTime till_dt;

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
                    setState(() async{
                      from = await _selectTime(context);
                      initial = from;
                      from_dt = new DateTime(now.year, now.month, now.day, from.hour, from.minute);
                      till = await _selectTime(context);
                      till_dt = new DateTime(now.year, now.month, now.day, till.hour, till.minute);
                      /*print("reached here");
                      print(from);
                      print(till);*/
                      setState(() {
                        appointments.add(Meeting(
                            from: from_dt,
                            to: till_dt,
                            title: 'Class',
                            isAllDay: false,
                            background: Colors.pink,
                            fromZone: '',
                            toZone: '',
                            recurrenceRule: '',
                            exceptionDates: null
                        ));
                      });
                    });
                  }
                  else if (value == 2) {
                    setState(() {
                      appointments.add(Meeting(
                          from: date,
                          to: date.add(const Duration(hours: 9)),
                          title: 'General Meeting2',
                          isAllDay: false,
                          background: Colors.pink,
                          fromZone: '',
                          toZone: '',
                          recurrenceRule: '',
                          exceptionDates: null
                      ));
                    });
                  }
                  else if (value == 3) {
                    setState(() {
                      appointments.add(Meeting(
                          from: date,
                          to: date.add(const Duration(hours: 8)),
                          title: 'General Meeting3',
                          isAllDay: false,
                          background: Colors.green,
                          fromZone: '',
                          toZone: '',
                          recurrenceRule: '',
                          exceptionDates: null
                      ));
                    });
                  }//_service.call(number);
                 },
              ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.week,
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: startHour,
          endHour: endHour,
        ),
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(appointments),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createMeeting,
      ),
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: initial, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
        );
        }
      );
    return picked_s;

    /*if (picked_s != null && picked_s != selectedTime )
      setState(() {
        //selectedTime = picked_s;
        return picked_s;
      });*/
  }

}


/*void calendarTapped(CalendarTapDetails calendarTapDetails) {
  if (calendarTapDetails.targetElement == CalendarElement.appointment) {
    Appointment appointment = calendarTapDetails.appointments[0];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute(appointment:appointment)),
    );
  }
}*/

/*MeetingDataSource _getCalendarDataSource() {
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
}*/
