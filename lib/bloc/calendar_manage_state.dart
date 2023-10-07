import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CalendarManageState {}

class CalendarManageInitial extends CalendarManageState {}

class ListOfSetsState extends CalendarManageState {
 final List<dynamic> listOfSets;
 
  List<dynamic> get getListOfSets => listOfSets;

  ListOfSetsState(this.listOfSets);
}