import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import '../model/event.dart' as evento;
import '../main.dart';
import '../utils/calendar_utils.dart';
import '../widgets/responsive.dart';
import '../widgets/web_scrollbar.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  double _scrollPosition = 0;

  double _opacity = 0;

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  late ScrollController _scrollController;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    getEvents();
    super.initState();
  }

  getEvents() async {
    await FirebaseFirestore.instance.collection('events').get().then((value) {
      value.docs.forEach((element) {
        print('here we are iefjowe');
        print(element.data());
        var r = int.parse(element['color'].toString().split(",")[0]);
        var g = int.parse(element['color'].toString().split(",")[1]);
        var b = int.parse(element['color'].toString().split(",")[2]);
        try {
          var event = CalendarEventData(
            date: element['date'].toDate(),
            color: Color.fromRGBO(r, g, b, 1.0),
            endTime: element['endTime'].toDate(),
            startTime: element['startTime'].toDate(),
            description: element['description'],
            endDate: element['endDate'].toDate(),
            title: element['title'],
            event: evento.Event(
              title: '${element['title']}}',
            ),
          );
          setState(() {
            eventController.add(event);
          });
        } catch (e) {
          print("this is error ${e.toString()}");
        }
      });
    });
  }

  final _breakPoint = 490.0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    final availableWidth = MediaQuery.of(context).size.width;
    final width = min(_breakPoint, availableWidth);

    return CalendarControllerProvider(
      controller: eventController,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          extendBodyBehindAppBar: true,
          appBar: ResponsiveWidget.isSmallScreen(context)
              ? AppBar(
                  backgroundColor:
                      Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
                  elevation: 0,
                  centerTitle: true,
                  actions: [
                    Visibility(
                      visible: false,
                      child: IconButton(
                        icon: Icon(Icons.brightness_6),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          EasyDynamicTheme.of(context).changeTheme();
                        },
                      ),
                    ),
                  ],
                  title: Image.asset('assets/images/logo-side-crop.png',
                      width: screenSize.width / 6,
                      height: screenSize.width / 12),
                )
              : PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: PreferredSize(
                    preferredSize: Size(screenSize.width, 1000),
                    child: Container(
                      color: Theme.of(context)
                          .bottomAppBarColor
                          .withOpacity(_opacity),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* Text(
                  'EXPLORE',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ),*/
                            Image.asset('assets/images/logo-side-crop.png',
                                width: screenSize.width / 6,
                                height: screenSize.width / 12),
                            SizedBox(
                              width: screenSize.width / 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          body: Center(
            child: SizedBox(
                // height: screenSize.height * 0.9,
                // width: MediaQuery.of(context).size.width * 0.7,
                child: Center(
                    child: MonthView(
              controller: eventController,
              width: width,
            ))),
          )),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }
}
