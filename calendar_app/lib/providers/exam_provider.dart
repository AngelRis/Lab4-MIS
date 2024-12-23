import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/exam.dart';

class ExamProvider with ChangeNotifier {
  final List<Exam> _exams = [];

  List<Exam> get exams => [..._exams];

  void addExam(String title, DateTime dateTime, LatLng location, String locationName) {
    final newExam = Exam(
      id: DateTime.now().toString(),
      title: title,
      dateTime: dateTime,
      location: location,
      locationName: locationName,
    );
    _exams.add(newExam);
    notifyListeners();
  }
  List<Exam> getExamsForDate(DateTime date) {
    return _exams
        .where((exam) =>
    exam.dateTime.year == date.year &&
        exam.dateTime.month == date.month &&
        exam.dateTime.day == date.day)
        .toList();
  }

}