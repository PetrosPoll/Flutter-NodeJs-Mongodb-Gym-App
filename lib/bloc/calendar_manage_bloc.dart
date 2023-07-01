library calendar_manage_bloc;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'calendar_manage_event.dart';
import 'calendar_manage_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CalendarManageBloc extends Bloc<CalendarManageEvent, CalendarManageState> {
  CalendarManageBloc() : super(CalendarManageInitial()) {

    on<AddAnEvent>((event, emit) {
    emit(CalendarReceiveData(event.exerciseName, event.isNewEvent));
    });

    on<SaveSet>((event, emit) async {
      final url = dotenv.env['API_URL'] ?? ''; // Use the URL in your API requests
      var completeURL = Uri.http(url, '/addExerciseSet');
      var response = await http.post(completeURL, body: {'username': event.username, 'reps': event.reps, 'weight': event.weight, 'date': event.date, 'exercise_name': event.exerciseName});

      if (response.statusCode == 200) {
        emit(CalendarManageInitial());
        print('COMPLETe INSERT');
      }else{
        print('FAILED INSERT!!');
      }
      
    });
  }
}
  