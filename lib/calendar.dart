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
            // selectedEvents[date]?.add( Event(title: object["exercise_name"], reps: object["reps"], weight: object["weight"]) );
        } else {
          selectedEvents[date] = [ Event(title: object["exercise_name"]) ];
          // selectedEvents[date] = [ Event(title: object["exercise_name"], reps: object["reps"], weight: object["weight"]) ];
      }
    }
    }

    // This is the state where we send data from an exercise to save it on the database and show it on calendar. 
    // More specifically the date here are coming from the page where we set an exercise of how many reps and weights
    if (state is CalendarReceiveData) {
      DateTime now = DateTime.now();
      DateTime formattedDateTime = DateTime.utc(now.year, now.month, now.day);
      String formattedDay = formattedDateTime.toUtc().toIso8601String();

      // Get the data from the state with the getters
      String exerciseName = state.getExerciseName;
      // String reps = state.getReps;
      // String weight = state.getWeight;
      bool isNewEvent = state.getIsNewEvent;

      if(isNewEvent){
        selectedEvents[selectedDay] = [
          Event(title: exerciseName)
          // Event(title: exerciseName, reps: reps, weight: weight)
        ];
        // BlocProvider.of<CalendarManageBloc>(context).add(SaveSet(false, 'pollakis.p6@gmail.com', reps, weight, formattedDay, exerciseName));
      }
    }
    return SingleChildScrollView(
    child: Container(
      color: Color.fromRGBO(200, 208, 200, 1),
        child: Column(
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
                (Event event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(
                      event.title,
                      // event.title + " - " + event.reps + " - " + event.weight,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
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

