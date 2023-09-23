import 'package:flutter/material.dart';
import 'exercise_details.dart';
import 'exercises_in_workout.dart';

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
      child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Padding(
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
                  ),
                  Container(
                    child: Wrap(
                      spacing: 16.0, // Spacing between each box
                      runSpacing: 16.0, // Spacing between each row
                      children: List.generate(20, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseDetails(
                                  exerciseName: 'Exercise ${index + 1}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 48) / 3, // Adjust the width based on the number of items per row
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[800],
                                  child: Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Exercise ${index + 1}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.transparent,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseList(),
                        ),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[900], // Set the background color of the button
                  ),
                  child: Text(
                    'Start Workout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
