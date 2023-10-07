library calendar_manage_bloc;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'calendar_manage_event.dart';
import 'calendar_manage_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class CalendarManageBloc extends Bloc<CalendarManageEvent, CalendarManageState> {
  CalendarManageBloc() : super(CalendarManageInitial()) {
 final url = dotenv.env['API_URL'] ?? ''; // Use the URL in your API requests

    on<ReceiveListOfSets>((event, emit) async {
    var completeURL = Uri.parse(url + '/receiveSetsList/' + event.username);
    var response = await http.get(completeURL);
    emit(ListOfSetsState(json.decode(response.body)));
    });

    on<SaveSet>((event, emit) async {
      var completeURL = Uri.parse('$url/addExerciseSet');
      var response = await http.post(completeURL, body: {'username': event.username, 'reps': jsonEncode(event.repsList), 'weight': jsonEncode(event.weightsList), 'date': event.date, 'exercise_name': event.exerciseName});

      if (response.statusCode == 200) {
        var completeURL = Uri.parse(url + '/receiveSetsList/' + event.username);
        var response = await http.get(completeURL);
        emit(ListOfSetsState(json.decode(response.body)));
        print('COMPLETE INSERT');
      }else{
        print('FAILED INSERT!!');
      }
    });
  }
}
  