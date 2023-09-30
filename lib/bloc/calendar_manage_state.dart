import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CalendarManageState {}

class CalendarManageInitial extends CalendarManageState {}

class CalendarReceiveData extends CalendarManageState {
  final String exerciseName;
  final bool isNewEvent;
  List<int> repsList = [];
  List<double> weightsList = [];

  String get getExerciseName => exerciseName;
  bool get getIsNewEvent => isNewEvent;
  List<int> get getRepsList => repsList;
  List<double> get getWeightsList => weightsList;

  CalendarReceiveData(this.exerciseName, this.isNewEvent, this.repsList, this.weightsList);
}

class ListOfSetsState extends CalendarManageState {
 final List<dynamic> listOfSets;
 
  List<dynamic> get getListOfSets => listOfSets;

  ListOfSetsState(this.listOfSets);
}