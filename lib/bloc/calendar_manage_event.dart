import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


@immutable
abstract class CalendarManageEvent {}

class ReceiveListOfSets extends CalendarManageEvent {
  final String username;

  ReceiveListOfSets(this.username);
}

class AddAnEvent extends CalendarManageEvent {
  final String exerciseName;
  final bool isNewEvent;
  List<int> repsList = [];
  List<double> weightsList = [];

  AddAnEvent(this.exerciseName, this.isNewEvent, this.repsList, this.weightsList);
}

class SaveSet extends CalendarManageEvent {
  final bool isNewEvent;
  final String username;
  List<int> repsList = [];
  List<double> weightsList = [];
  final String date;
  final String exerciseName;

  SaveSet(this.isNewEvent, this.username, this.repsList, this.weightsList, this.date, this.exerciseName);
}