import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import 'location_picker_screen.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _titleController = TextEditingController();
  final _locationNameController = TextEditingController();
  DateTime? _selectedDateTime;
  LatLng? _selectedLocation;

  void _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _pickLocation() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => LocationPickerScreen()),
    );
    if (pickedLocation == null) return;
    setState(() {
      _selectedLocation = pickedLocation;
    });
  }

  void _saveExam() {
    if (_titleController.text.isEmpty ||
        _selectedDateTime == null ||
        _selectedLocation == null ||
        _locationNameController.text.isEmpty) {
      return;
    }
    Provider.of<ExamProvider>(context, listen: false).addExam(
      _titleController.text,
      _selectedDateTime!,
      _selectedLocation!,
      _locationNameController.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const appBarColor = Colors.blueAccent;  // Accent Blue Color

    return Scaffold(
      appBar: AppBar(
        title: const Text('Нов Испит',style: TextStyle(color: Colors.white),),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Име на Испит',
                labelStyle: const TextStyle(color: appBarColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appBarColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appBarColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationNameController,
              decoration: InputDecoration(
                labelText: 'Име на Локација',
                labelStyle: const TextStyle(color: appBarColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appBarColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appBarColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDateTime,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBarColor, // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Одбери Датум и Време'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedDateTime != null
                        ? '${'${_selectedDateTime!.toLocal()}'.split(' ')[0]} ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}'
                        : 'Не е избран датум и време',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBarColor, // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Одбери Локација'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedLocation != null
                        ? '${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}'
                        : 'Не е избрана локација',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveExam,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54, // Button color
                foregroundColor: Colors.white, // Text color
                minimumSize: const Size(double.infinity, 50), // Full width and large height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Зачувај',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}