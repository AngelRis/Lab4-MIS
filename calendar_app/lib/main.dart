import 'package:calendar_app/providers/exam_provider.dart';
import 'package:calendar_app/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExamProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Календар на полагања',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CalendarScreen(),
      ),
    );
  }
}