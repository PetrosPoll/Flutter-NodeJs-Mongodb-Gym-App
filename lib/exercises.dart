import 'package:flutter/material.dart';
import 'exercise_details.dart';
import 'exercises_in_workout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'models/exercise.dart'; // Import the Exercise class
import 'dart:convert';

class Exercises extends StatefulWidget {
  final VoidCallback? callbackFromCalendar;

  Exercises({this.callbackFromCalendar});

  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  int _selectedIndex = 0; // The initially selected tab index
  final url = dotenv.env['API_URL'] ?? ''; // Use the URL in your API requests
  List<Exercise> exerciseList = [];

 @override
  void initState() {
    super.initState();

    fetchData(url);
  }

  Future<void> fetchData(url) async {
      var completeURL = Uri.parse('$url/exercises');  // Use Uri.parse() instead of Uri.http()
      var response = await http.get(completeURL);

      if (response.statusCode == 200) {
        List<dynamic> responseList = json.decode(response.body);
        setState(() {
          exerciseList = responseList.map((e) => Exercise.fromJson(e)).toList();
        });
      } else {
        // Handle API request error
        print('API request failed with status code: ${response.statusCode}');
      }
  }


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
                    height: 500,
                    child:
                      GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: exerciseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Exercise exercise = exerciseList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseDetails(
                                  exerciseName: exercise.name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 100, // Adjust this value as needed
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
                                  exercise.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
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
