import 'package:flutter/material.dart';

class MedicineDetail extends StatelessWidget {
  final String medicineName;

  // Constructor to accept medicine name dynamically
  const MedicineDetail({super.key, required this.medicineName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(240.0), // Expanded AppBar height
        child: Column(
          children: [
            // ✅ Main AppBar
            AppBar(
              backgroundColor: Colors.blue[900],
              automaticallyImplyLeading: true, // Adds a back button
            ),

            // ✅ Extended AppBar with Medicine Image & Name
            Container(
              color: Colors.blue[900], // Matches AppBar color
              height: 184,
              width: double.infinity, // Take full width
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Medicine Image (Same for all)
                  Image.asset(
                    "assets/images/aspirin.png",
                    height: 120, // Adjust size
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                
                  // Medicine Name (Dynamic)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      medicineName,
                      style: const TextStyle(
                        fontSize: 27,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure visibility
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ✅ Body Section
      body: Column(
        children: [
          const SizedBox(height: 20), // Space below AppBar

          // ✅ Centered Content with Three Rows
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Keeps content centered
                children: [
                  // ✅ Row 1: Dosage
                  _buildRow(
                    heading: "Dosage",
                    subheading: "3 times:",
                    widgets: [
                      _buildTimePill("9AM"),
                      _buildTimePill("3PM"),
                      _buildTimePill("9PM"),
                    ],
                  ),

                  const SizedBox(height: 15), // Spacing between rows

                  // ✅ Row 2: Program
                  _buildRow(
                    heading: "Program",
                    subheading: "Total 8 weeks: 6 weeks left",
                  ),

                  const SizedBox(height: 15), // Spacing between rows

                  // ✅ Row 3: Quantity
                  _buildRow(
                    heading: "Quantity",
                    subheading: "Total 168 tablets: 126 tablets left",
                  ),
                ],
              ),
            ),
          ),

          // ✅ Change Schedule Button at Bottom Center
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add schedule change functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Change Schedule",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Reusable Widget for Row
  Widget _buildRow({required String heading, required String subheading, List<Widget>? widgets}) {
    return Column(
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subheading,
              style: const TextStyle(fontSize: 16),
            ),
            if (widgets != null) ...[
              const SizedBox(width: 10),
              Wrap(
                spacing: 10,
                children: widgets,
              ),
            ],
          ],
        ),
      ],
    );
  }

  // ✅ Widget for Small Green Time Rectangles
  Widget _buildTimePill(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[400], // Green background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}