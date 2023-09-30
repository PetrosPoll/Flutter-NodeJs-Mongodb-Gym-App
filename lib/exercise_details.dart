import 'package:flutter/material.dart';
import 'dart:async';
import 'timer.dart';
import 'calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calendar_manage_bloc.dart';
import 'bloc/calendar_manage_event.dart';
import 'bloc/calendar_manage_state.dart';

class ExerciseDetails extends StatefulWidget {
  final String exerciseName;

  ExerciseDetails({required this.exerciseName});

  @override
  _ExerciseDetailsState createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isCountdownStarted = false;
  int countdownDuration = 120;
  int countdownValue = 120;
  bool isCountdownComplete = false;
  Timer? _timer;
  List<int> repsList = [0];
  List<double> weightsList = [0.0];
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void addRow() {
    setState(() {
      repsList.add(0);
      weightsList.add(0.0);
    });
  }

 void removeRow() {
  setState(() {
    repsList.removeLast();
    weightsList.removeLast();
  });
}

  void startCountdown() {
    isCountdownStarted = true;
    countdownValue = countdownDuration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownValue > 0) {
          countdownValue--;
        } else {
          timer.cancel();
          isCountdownStarted = false;
          isCountdownComplete = true;
        }
      });
    });
  }

  void resetCountdown() {
    _timer?.cancel();
    setState(() {
      countdownValue = countdownDuration;
      isCountdownStarted = false;
      isCountdownComplete = false;
    });
  }

   Widget buildRepsWeightsRow(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  repsList[index] = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                hintText: 'REPS',
                labelText: 'Reps',
                labelStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  weightsList[index] = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Weights (kg)',
                labelStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarManageBloc, CalendarManageState>(
    builder: (context, text) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Exercise Details',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.grey[800],
                child: Center(
                  child: Text(
                    '${widget.exerciseName}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'SETS ${repsList.length}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              for (int i = 0; i < repsList.length; i++)
                buildRepsWeightsRow(i),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: addRow,
                      child: Icon(Icons.add),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: removeRow,
                      child: Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
              CountdownRowWidget(
                countdownValue: countdownValue,
                isCountdownStarted: isCountdownStarted,
                isCountdownComplete: isCountdownComplete,
                startCountdown: startCountdown,
                resetCountdown: resetCountdown,
              ),
              Center(
                child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Are you sure you want to complete this exercise?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<CalendarManageBloc>(context).add(AddAnEvent('${widget.exerciseName}', true, repsList, weightsList));
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Complete Exercise'),
              )
              ),
            ],
          ),
        ),
      ),
      );// End of Gesture 
    }
    ); // End of BlocProvider
  }
}
