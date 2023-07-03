import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calendar_manage_bloc.dart';
import 'bloc/calendar_manage_event.dart';
import 'bloc/calendar_manage_state.dart';
import 'package:intl/intl.dart';

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
      selectedEvents = {};
      list_of_sets = state.getListOfSets;

    for (int i = 0; i < list_of_sets.length; i++) {
      var object = list_of_sets[i];
      String dateString = object["date"];
      DateTime date = DateTime.parse(dateString);
        if (selectedEvents[selectedDay] != null) {
            selectedEvents[date]?.add( Event(title: object["exercise_name"]) );
        } else {
          selectedEvents[date] = [ Event(title: object["exercise_name"]) ];
      }
    }
    }

    // Receive data from the state and handle them
    if (state is CalendarReceiveData) {
      // Get the data from the state with the getters
      String exerciseName = state.getExerciseName;
      bool isNewEvent = state.getIsNewEvent;
        if(isNewEvent){
          selectedEvents[selectedDay] = [
            Event(title: exerciseName)
          ];
          BlocProvider.of<CalendarManageBloc>(context).add(SaveSet(false, 'pollakis.p6@gmail.com', '23', '54', '2023-07-02 00:00:00.000Z', exerciseName));
        }
    }
    return Scaffold(
    body: Column(
        children: [
          TableCalendar(
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
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {

                  } else {
                      if (selectedEvents[selectedDay] != null) {
                        selectedEvents[selectedDay]?.add(
                          Event(title: _eventController.text),
                        );
                      } else {
                        selectedEvents[selectedDay] = [
                          Event(title: _eventController.text)
                        ];
                      }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    ); // End scaffold
  }
  );
  }
}

