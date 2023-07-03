import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CalendarManageState {}

class CalendarManageInitial extends CalendarManageState {}

class CalendarReceiveData extends CalendarManageState {
  final String exerciseName;
  final bool isNewEvent;

  String get getExerciseName => exerciseName;
  bool get getIsNewEvent => isNewEvent;

  CalendarReceiveData(this.exerciseName, this.isNewEvent);
}

class ListOfSetsState extends CalendarManageState {
 final List<dynamic> listOfSets;
 
  List<dynamic> get getListOfSets => listOfSets;

  ListOfSetsState(this.listOfSets);
}