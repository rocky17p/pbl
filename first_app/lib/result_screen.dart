import 'package:flutter/material.dart';
import 'services/firestore_service.dart';
import 'services/nlp_service.dart';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late List<Map<String, String>> medicines;
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _dosageControllers;
  late List<TextEditingController> _frequencyControllers;
  late List<TextEditingController> _durationControllers;
  late List<TextEditingController>
      _timingControllers; // Added Timing Controllers

  @override
  void initState() {
    super.initState();

    // Extract details using NLP
    final extractedData = extractPrescriptionDetails(widget.text);
    medicines = extractedData['medicines'];

    // Initialize controllers with extracted data
    _nameControllers = medicines
        .map((med) => TextEditingController(text: med['name']))
        .toList();
    _dosageControllers = medicines
        .map((med) => TextEditingController(text: med['dosage']))
        .toList();
    _frequencyControllers = medicines
        .map((med) => TextEditingController(text: med['frequency']))
        .toList();
    _durationControllers = medicines
        .map((med) => TextEditingController(text: med['duration']))
        .toList();
    _timingControllers = medicines
        .map((_) =>
            TextEditingController(text: "")) // Allow users to enter timing
        .toList();

    // Show confirmation dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showConfirmationDialog();
    });
  }

  @override
  void dispose() {
    for (var controller in [
      ..._nameControllers,
      ..._dosageControllers,
      ..._frequencyControllers,
      ..._durationControllers,
      ..._timingControllers
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  // Confirmation Dialog (Ensures timing input)
  Future<void> _showConfirmationDialog() async {
    bool confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Prescription Details"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: medicines.asMap().entries.map((entry) {
                  final index = entry.key;
                  final med = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Medicine ${index + 1}:"),
                      Text("Name: ${med['name']}"),
                      Text("Dosage: ${med['dosage']}"),
                      Text("Frequency: ${med['frequency']}"),
                      Text("Duration: ${med['duration']}"),
                      TextField(
                        controller: _timingControllers[index],
                        decoration: const InputDecoration(
                            labelText: "Enter Time (e.g., 08:00 AM)"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Edit"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Confirm"),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    // Save to Firestore if confirmed
    _savePrescriptions();
  }

  // Save all prescriptions to Firestore
  void _savePrescriptions() {
    for (int i = 0; i < medicines.length; i++) {
      String name = _nameControllers[i].text.trim();
      String dosage = _dosageControllers[i].text.trim();
      String frequency = _frequencyControllers[i].text.trim();
      String duration = _durationControllers[i].text.trim();
      String timing = _timingControllers[i].text.trim();

      if (timing.isEmpty) {
        timing = "08:00 AM"; // Fallback default if user doesn't enter timing
      }

      print(
          "Saving: $name, $dosage, $frequency, $duration, $timing"); // Debugging

      if (name.isNotEmpty && dosage.isNotEmpty && frequency.isNotEmpty) {
        _firestoreService.addPrescription(
            name, dosage, frequency, duration, timing);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Prescriptions saved successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Prescription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameControllers[index],
                      decoration:
                          const InputDecoration(labelText: 'Medicine Name'),
                    ),
                    TextField(
                      controller: _dosageControllers[index],
                      decoration: const InputDecoration(labelText: 'Dosage'),
                    ),
                    TextField(
                      controller: _frequencyControllers[index],
                      decoration: const InputDecoration(labelText: 'Frequency'),
                    ),
                    TextField(
                      controller: _durationControllers[index],
                      decoration: const InputDecoration(labelText: 'Duration'),
                    ),
                    TextField(
                      controller: _timingControllers[index],
                      decoration: const InputDecoration(
                          labelText: 'Timing (e.g., 08:00 AM)'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _savePrescriptions,
        child: const Icon(Icons.save),
      ),
    );
  }
}
