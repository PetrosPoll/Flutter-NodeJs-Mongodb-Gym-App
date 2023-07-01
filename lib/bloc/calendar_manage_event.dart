import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


@immutable
abstract class CalendarManageEvent {}

class AddAnEvent extends CalendarManageEvent {
  final String exerciseName;
  final bool isNewEvent;

  AddAnEvent(this.exerciseName, this.isNewEvent);
}

class SaveSet extends CalendarManageEvent {
  final bool isNewEvent;
  final String username;
  final String reps;
  final String weight;
  final String date;
  final String exerciseName;

  SaveSet(this.isNewEvent, this.username, this.reps, this.weight, this.date, this.exerciseName);
}