import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/exam_provider.dart';
import 'add_exam_screen.dart';
import 'map_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context);
    final examsForSelectedDate = examProvider.getExamsForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Календар на Полагања \n(211095)',style: TextStyle(color: Colors.white),),
        elevation: 8.0,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.map, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MapScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _selectedDate,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              eventLoader: (day) =>
                  examProvider.getExamsForDate(day).map((e) => e.title).toList(),
              calendarStyle: const CalendarStyle(
                todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),
                todayDecoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle
                ),
                selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.arrow_back, color: Colors.blueAccent),
                rightChevronIcon: Icon(Icons.arrow_forward, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: examsForSelectedDate.length,
                itemBuilder: (ctx, i) {
                  final exam = examsForSelectedDate[i];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      title: Text(
                        "Испит по: ${exam.title}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        'Време: ${exam.dateTime.hour.toString().padLeft(2, '0')}:${exam.dateTime.minute.toString().padLeft(2, '0')}\nЛокација: ${exam.locationName}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddExamScreen()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}