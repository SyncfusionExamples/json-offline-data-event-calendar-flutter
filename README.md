# How to load the JSON data (offline) for the Flutter event calendar (SfCalendar) appointments

In the Flutter event calendar, you can load the JSON data for the Flutter calendar events from the JSON file. Here we are using own data`s in the JSON file.

## Step 1:
Place the required data’s in the .json file.

```xml
[
  {
    "name":"Meeting",
    "start":"05/04/2020 06:00:00",
    "end": "05/04/2020 07:00:00",
    "color": "red"
  },
  {
    "name":"Planning",
    "start":"07/04/2020 01:00:00",
    "end": "07/04/2020 02:00:00",
    "color": "red"
  },
  {
    "name":"Retrospective",
    "start":"09/04/2020 02:00:00",
    "end": "09/04/2020 03:00:00",
    "color": "red"
  },
  {
    "name":"Release",
    "start":"08/04/2020 07:00:00",
    "end": "08/04/2020 08:00:00",
    "color": "red"
  }
]
```
 

## Step 2:
Access those data using the `FutureBuilder` widget. Please find the following code snippet for the same.

```xml
child: FutureBuilder(
  builder: (context, snapshot) {
    var showData = json.decode(snapshot.data.toString());
    List<Meeting> collection;
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
      .loadString("assets/appointments.json"),
),
```
**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/11466/how-to-load-the-json-data-offline-for-the-flutter-event-calendar-sfcalendar-appointments)**

**Screenshots**

<img alt="json data"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-798/flut-798_img1.png" width="300" height="500" />|
