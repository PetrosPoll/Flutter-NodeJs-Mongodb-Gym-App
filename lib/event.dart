import 'package:flutter/foundation.dart';

class Event {
  final String title;

  Event({required this.title});

  @override
  String toString() {
    return title;
  }
}