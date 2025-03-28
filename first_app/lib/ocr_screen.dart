import 'dart:io';
import 'package:first_app/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/firestore_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  final TextRecognizer _textRecognizer = TextRecognizer();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _timingController = TextEditingController();

  TimeOfDay? _selectedTime; // Holds selected time

  Future<void> _scanImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      final inputImage = InputImage.fromFile(File(pickedFile.path));
      final recognizedText = await _textRecognizer.processImage(inputImage);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to process image: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> _selectTime() async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );

  //   if (pickedTime != null) {
  //     setState(() {
  //       _selectedTime = pickedTime;
  //       _timingController.text = _formatTime(pickedTime);
  //     });
  //   }
  // }

  // String _formatTime(TimeOfDay time) {
  //   final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  //   final minute = time.minute.toString().padLeft(2, '0');
  //   final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  //   return '$hour:$minute $period';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescription Scanner')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:
                  _isLoading ? null : () => _scanImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan from Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:
                  _isLoading ? null : () => _scanImage(ImageSource.gallery),
              icon: const Icon(Icons.image),
              label: const Text('Scan from Gallery'),
            ),
            const SizedBox(height: 20),

            // ---- COMMENTED OUT THE TIME PICKER ----
            /*
            TextField(
              controller: _timingController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Select Timing",
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _selectTime,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            */

            if (_isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanImage(ImageSource.camera),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
