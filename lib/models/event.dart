import 'package:flutter/foundation.dart';

class Event {
  final String title;
  late List<int> repsList;
  late List<double> weightsList;

  Event({required this.title, required this.repsList, required this.weightsList});

  @override
  String toString() {
    return title;
  }

  List<int> getReps() {
    return repsList;
  }

  List<double> getWeights() {
    return weightsList;
  }
}