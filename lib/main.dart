import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(CalendarJson());

class CalendarJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Hello',
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  @override
  MyAppPageState createState() => MyAppPageState();
}

class MyAppPageState extends State<MyAppPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('AppBar'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            List<Meeting>? collection;
            if (showData != null) {
              for (int i = 0; i < showData.length; i++) {
                collection ??= <Meeting>[];
                collection.add(Meeting(
                    eventName: showData[i]['name'],
                    isAllDay: false,
                    from: DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(showData[i]['start']),
                    to: DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(showData[i]['end']),
                    background: Colors.green));
              }
            }
            return Container(
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: _getCalendarDataSource(collection),
                  monthViewSettings: MonthViewSettings(showAgenda: true),
                ));
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/appointment.json"),
        ),
      ),
    );
  }

  MeetingDataSource _getCalendarDataSource([List<Meeting>? collection]) {
    List<Meeting> meetings = collection ?? <Meeting>[];
    return MeetingDataSource(meetings);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
}
