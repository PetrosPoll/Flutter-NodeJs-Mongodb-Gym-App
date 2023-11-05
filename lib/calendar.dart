import 'models/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calendar_manage_bloc.dart';
import 'bloc/calendar_manage_event.dart';
import 'bloc/calendar_manage_state.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();
  List<dynamic> list_of_sets = [];

  @override
  void initState() {
    print('Initial state for calendar.dart---');
    selectedEvents = {};
    BlocProvider.of<CalendarManageBloc>(context).add(ReceiveListOfSets('pollakis.p6@gmail.com'));
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  static Calendar? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Calendar>();
  }

  @override
  Widget build(BuildContext context) {
  return BlocBuilder<CalendarManageBloc, CalendarManageState>(
  builder: (context, state) {
    if (state is ListOfSetsState) {
      print('ListOfSetsState----');
      selectedEvents = {};
      list_of_sets = state.getListOfSets;

      for (int i = 0; i < list_of_sets.length; i++) {
        var object = list_of_sets[i];
        String dateString = object["date"];
        DateTime date = DateTime.parse(dateString);

        if (selectedEvents[selectedDay] != null) {
            selectedEvents[date]?.add( Event(title: object["exercise_name"], repsList: List<int>.from(json.decode(object["reps"])), weightsList: List<double>.from(json.decode(object["weight"] )) ));
        } else {
          selectedEvents[date] = [ Event(title: object["exercise_name"], repsList: List<int>.from(json.decode(object["reps"])), weightsList: List<double>.from(json.decode(object["weight"] )) )];
        }
      }
    }

    return SingleChildScrollView(
    child: Container(
      color: Colors.grey,
        child: Column(
            children: [
              TableCalendar(
                calendarStyle: CalendarStyle(
                  
                ) ,
                locale: 'en_US',
                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,
    
                //Day Changed
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                eventLoader: _getEventsfromDay,
              ),
    
              ..._getEventsfromDay(selectedDay).map(
                (Event event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title, // Main title
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5), // Add some space between the title and reps
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            event.repsList.length,
                            (index) => Text(
                              '${event.repsList[index]} Reps x ${event.weightsList[index]} Kg',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    ),
    ); // End scaffold
  }
  );
  }
}

