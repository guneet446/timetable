import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Meeting.dart';
import 'MeetingDataSource.dart';

List<Meeting> appointments = <Meeting>[];

class Timetable extends StatefulWidget {
  Timetable({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  double startHour = 7;
  double endHour = 20;
  DateTime selectedDate = new DateTime.now();
  DateTime now = new DateTime.now();
  TimeOfDay initial = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay from = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay till = TimeOfDay(hour: 0, minute: 0);
  DateTime from_dt;
  DateTime till_dt;
  String help;
  String description;

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
                onSelected: (value) async {
                  if (value == 1) {
                    setState(() async{
                      await _getDescription(context);
                      help = "From";
                      from = await _selectTime(context);
                      initial = from;
                      from_dt = new DateTime(now.year, now.month, now.day, from.hour, from.minute);
                      help = "To";
                      till = await _selectTime(context);
                      till_dt = new DateTime(now.year, now.month, now.day, till.hour, till.minute);
                      initial = TimeOfDay(hour: 0, minute: 0);
                      setState(() {
                        appointments.add(Meeting(
                            from: from_dt,
                            to: till_dt,
                            title: description,
                            isAllDay: false,
                            background: Colors.pink,
                            fromZone: '',
                            toZone: '',
                            recurrenceRule: 'FREQ=DAILY;INTERVAL=7',
                            exceptionDates: null
                        ));
                      });
                    });
                  }
                  else if (value == 2) {
                    setState(() async{
                      await _getDescription(context);
                      await _selectDate(context);
                      help = "From";
                      from = await _selectTime(context);
                      initial = from;
                      from_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, from.hour, from.minute);
                      help = "To";
                      till = await _selectTime(context);
                      till_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, till.hour, till.minute);
                      initial = TimeOfDay(hour: 0, minute: 0);
                      setState(() {
                        appointments.add(Meeting(
                            from: from_dt,
                            to: till_dt,
                            title: description,
                            isAllDay: false,
                            background: Colors.blue,
                            fromZone: '',
                            toZone: '',
                            recurrenceRule: '',
                            exceptionDates: null
                        ));
                      });
                    });
                  }
                  else if (value == 3) {
                    setState(() async{
                      await _getDescription(context);
                      await _selectDate(context);
                      help = "From";
                      from = await _selectTime(context);
                      initial = from;
                      from_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, from.hour, from.minute);
                      help = "To";
                      till = await _selectTime(context);
                      till_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, till.hour, till.minute);
                      initial = TimeOfDay(hour: 0, minute: 0);
                      setState(() {
                        appointments.add(Meeting(
                            from: from_dt,
                            to: till_dt,
                            title: description,
                            isAllDay: false,
                            background: Colors.green,
                            fromZone: '',
                            toZone: '',
                            recurrenceRule: '',
                            exceptionDates: null
                        ));
                      });
                    });
                  }
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
        onLongPress: _deleteSelected,
      ),
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        helpText: help,
        initialTime: initial, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
        );
        }
      );
    return picked_s;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final myController = TextEditingController();

  _getDescription(BuildContext context) async{
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Text("Subject"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: myController,
                decoration: InputDecoration(
                    labelText: 'Subject'
                ),
                validator: (val) {
                return val.isEmpty ? 'Enter the subject name' : null;
                },
              ),
              TextButton(
                onPressed:() {
                  _setText();
                  Navigator.pop(context);
                  },
                child: Text('Submit'),
              ),
            ],
          ),
      );
    });
  }

  void _setText() {
    setState(() {
      description = myController.text;
    });
  }

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

  _deleteSelected(CalendarLongPressDetails details) {
    final Meeting tappedAppointment = details.appointments[0];

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Delete ${tappedAppointment.title}?'),

        actions: <Widget>[
                new TextButton(
                    child: new Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new TextButton(
                  child: new Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //customReminders.remove(customReminder);
                    appointments.remove(tappedAppointment);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Timetable()),
                    );
                  },
                ),
              ],
      );
    });
  }
}