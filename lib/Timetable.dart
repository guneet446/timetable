import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'Meeting.dart';
import 'MeetingDataSource.dart';

List<Meeting> appointments = <Meeting>[];
List<String> subjectList = ['Machine Learning', 'Operating Systems', 'Computer Networks', 'DBMS', 'EAD'];
List<String> subtitleList = ['Lecture', 'Tutorial', 'Lab'];
List<int> colors = [0xffFF9990, 0xff9ED2C0, 0xffC2DEE5, 0xffDCC0EC, 0xffE8C6AE, 0xffB2829D, 0xff55AAB2, 0xffD3D896, 0xffD9B6A9, 0xffABA68E];

class Timetable extends StatefulWidget {
  Timetable({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  double startHour = 6;
  double endHour = 22;
  DateTime selectedDate = new DateTime.now();
  int selectedDay;
  DateTime now = new DateTime.now();
  DateTime firstDateOfWeek;
  TimeOfDay initial = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay from = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay till = TimeOfDay(hour: 0, minute: 0);
  DateTime from_dt;
  DateTime till_dt;
  String help;
  String title;
  String subtitle = "Lecture";
  String subject = 'EAD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable", style: TextStyle( color: Color(0xffCADBE4), fontSize: 32,),),
        backgroundColor: Color(0xff588297),
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
                    await getSubject(context);
                    await selectDay();
                    print(selectedDay);
                    selectedDate = firstDateOfWeek.add(Duration(days: (selectedDay - 1)));
                    help = "From";
                    from = await selectTime(context);
                    initial = from;
                    from_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, from.hour, from.minute);
                    help = "To";
                    till = await selectTime(context);
                    till_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, till.hour, till.minute);
                    initial = TimeOfDay(hour: 0, minute: 0);
                    setState(() {
                      appointments.add(Meeting(
                          from: from_dt,
                          to: till_dt,
                          title: subject + " " + subtitle,
                          isAllDay: false,
                          background: Color(colors[subjectList.indexOf(subject)]),
                          fromZone: '',
                          toZone: '',
                          recurrenceRule: 'FREQ=DAILY;INTERVAL=7',
                          exceptionDates: null
                      ));
                    });
                  }
                  else if (value == 2) {
                    await getSubject(context);
                    await selectDate(context);
                    help = "From";
                    from = await selectTime(context);
                    initial = from;
                    from_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, from.hour, from.minute);
                    help = "To";
                    till = await selectTime(context);
                    till_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, till.hour, till.minute);
                    initial = TimeOfDay(hour: 0, minute: 0);
                    setState(() {
                      appointments.add(Meeting(
                          from: from_dt,
                          to: till_dt,
                          title: subject + " " + subtitle,
                          isAllDay: false,
                          background: Colors.blue,
                          fromZone: '',
                          toZone: '',
                          recurrenceRule: '',
                          exceptionDates: null
                      ));
                    });
                  }
                  else if (value == 3) {
                    await getTitle(context);
                    await selectDate(context);
                    help = "From";
                    from = await selectTime(context);
                    initial = from;
                    from_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, from.hour, from.minute);
                    help = "To";
                    till = await selectTime(context);
                    till_dt = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, till.hour, till.minute);
                    initial = TimeOfDay(hour: 0, minute: 0);
                    setState(() {
                      appointments.add(Meeting(
                          from: from_dt,
                          to: till_dt,
                          title: title,
                          isAllDay: false,
                          background: Colors.green,
                          fromZone: '',
                          toZone: '',
                          recurrenceRule: '',
                          exceptionDates: null
                      ));
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
        onLongPress: deleteSelected,
      ),
    );
  }

  Future<TimeOfDay> selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        helpText: help,
        initialTime: initial, builder: (BuildContext context, Widget child) {
      /*return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
        );*/
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color(0xff588297),
          accentColor: Color(0xffE28F22),
          colorScheme: ColorScheme.light(primary: Color(0xff235790),),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
          ),
        ),
        child: child,
      );
        }
      );
    return picked_s;
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff588297),
            accentColor: Color(0xffE28F22),
            colorScheme: ColorScheme.light(primary: Color(0xff235790),),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  selectDay() {
    firstDateOfWeek = now.subtract(Duration(days: now.weekday - 1));
    print(firstDateOfWeek);
    final values = List.filled(7, true);
    return showDialog(context: context, builder: (context) {
      return WeekdaySelector(
        color: Color(0xff235790),
        fillColor: Color(0xff235790),
        selectedFillColor: Color(0xff235790),
        //textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        onChanged: (int day) {
          setState(() {
            selectedDay = day;
            final index = day % 7;
            values[index] = !values[index];
            Navigator.pop(context);
          });
        },
        values: values,
      );
    },);
  }

  getSubject(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Subject"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // for dropdown to open in correct direction go to dropdown.dart and set selectedItemOffset to -40
            DropdownButton<String>(
              value: subject,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Color(0xffE28F22),
              ),
              onChanged: (String newValue) {
                setState(() {
                  subject = newValue;
                });
                //_setSubject(newValue);
              },
              items: subjectList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            DropdownButton<String>(
              value: subtitle,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                  color: Color(0xffE28F22),
              ),
              onChanged: (String newValue) {
                setState(() {
                  subtitle = newValue;
                });
                //_setSubject(newValue);
              },
              items: subtitleList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
              onPressed:() {
                Navigator.pop(context);
              },
              child: Text('Submit', style: TextStyle(color: Color(0xff235790), fontSize: 16)),
            ),
          ],
        ),
      );
    });
  }

  final myController = TextEditingController();

  getTitle(BuildContext context) {
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
                  setTitle();
                  Navigator.pop(context);
                  },
                child: Text('Submit'),
              ),
            ],
          ),
      );
    });
  }

  void setTitle() {
    setState(() {
      title = myController.text;
    });
  }

  deleteSelected(CalendarLongPressDetails details) {
    final Meeting tappedAppointment = details.appointments[0];

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Delete ${tappedAppointment.title}?'),
        actions: <Widget>[
                new TextButton(
                    child: new Text('Cancel', style: TextStyle(color: Color(0xff235790), fontSize: 16)),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new TextButton(
                  child: new Text('Delete', style: TextStyle(color: Color(0xff235790), fontSize: 16)),
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