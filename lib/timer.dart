import 'package:flutter/material.dart';

class CountdownRowWidget extends StatelessWidget {
  final int countdownValue;
  final bool isCountdownStarted;
  final bool isCountdownComplete;
  final VoidCallback startCountdown;
  final VoidCallback resetCountdown;

  CountdownRowWidget({
    required this.countdownValue,
    required this.isCountdownStarted,
    required this.isCountdownComplete,
    required this.startCountdown,
    required this.resetCountdown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Countdown:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                '${countdownValue ~/ 60}:${(countdownValue % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: isCountdownStarted ? resetCountdown : startCountdown,
                child: Text(
                  isCountdownStarted ? 'Reset' : 'Start',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
