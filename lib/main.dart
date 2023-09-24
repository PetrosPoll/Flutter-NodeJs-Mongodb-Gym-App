import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'bloc/calendar_manage_bloc.dart';
import 'bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'bloc/calendar_manage_event.dart';
import 'bloc/calendar_manage_state.dart';

void main() async {
  await dotenv.load(fileName: ".env" ); //path to your .env file
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarManageBloc(),
      child: MaterialApp(
        title: 'My Flutter App',
        theme: ThemeData(
          primaryColor: Colors.blue[800],
          scaffoldBackgroundColor: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(
            color: Colors.blue[800],
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final url = dotenv.env['API_URL'] ?? ''; // Use the URL in your API requests
  String username = '';
  String password = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            onChanged: (value) {
              username = value;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var completeURL = Uri.parse('$url/login');  // Use Uri.parse() instead of Uri.http()
                var response = await http.post(completeURL, body: {'username': 'root', 'password': '1234'});

                if (response.statusCode == 200) {
                  print('Pass the login credentials');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigationBarExample()),
                  );
                } else {
                  // Handle API request error
                  print('API request failed with status code: ${response.statusCode}');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
