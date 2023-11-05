import 'dart:async';
import 'package:bloc/bloc.dart';

// Events
abstract class WorkoutTimerEvent {}

class StartTimerEvent extends WorkoutTimerEvent {}

class EndTimerEvent extends WorkoutTimerEvent {}

// States
abstract class WorkoutTimerState {}

class TimerRunningState extends WorkoutTimerState {
  final int currentTime;
  TimerRunningState(this.currentTime);
}

class TimerEndedState extends WorkoutTimerState {}

class WorkoutTimerBloc extends Bloc<WorkoutTimerEvent, WorkoutTimerState> {
  late Timer _timer;
  int _currentTime = 0;

  WorkoutTimerBloc() : super(TimerEndedState());

  @override
  Stream<WorkoutTimerState> mapEventToState(WorkoutTimerEvent event) async* {
    if (event is StartTimerEvent) {
      yield* _startTimer();
    } else if (event is EndTimerEvent) {
      yield* _endTimer();
    }
  }

  Stream<WorkoutTimerState> _startTimer() async* {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime++;
      yield TimerRunningState(_currentTime);
    });
  }

  Stream<WorkoutTimerState> _endTimer() async* {
    _timer.cancel();
    yield TimerEndedState();
    _currentTime = 0; // Reset the timer
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
