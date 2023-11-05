import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationBarExample()),
            );
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}