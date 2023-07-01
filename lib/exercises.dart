import 'package:flutter/material.dart';
import 'exercise_details.dart';


class Exercises extends StatefulWidget {
  final VoidCallback? callbackFromCalendar;

  Exercises({this.callbackFromCalendar});

  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  int _selectedIndex = 0; // The initially selected tab index

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'List of Exercises',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Exercise ${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetails( exerciseName: 'Exercise ${index + 1}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
