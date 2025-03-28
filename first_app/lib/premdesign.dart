import 'package:first_app/ocr_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/MedicineDetail.dart';
//import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class Design extends StatelessWidget {
  const Design({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(178, 38, 3, 99)),
        useMaterial3: true,
      ),
    );
  }
}

class myhomepage extends StatefulWidget {
  const myhomepage({super.key, required this.title});

  final String title;

  @override
  State<myhomepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<myhomepage> {
  @override
  Widget build(BuildContext context) {
    var arrNames = ["Aspirin", "Cymbalta", "Lexapro", "Codeline"];
    var arrSubtitles = ["09:00 AM", "10:00 AM", "03:00 PM", "10:00 PM"];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.blue[900],
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.png')),
                ),
              ],
            ),
            Container(
              color: Colors.blue[900],
              height: 84,
              child: const Center(),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // Top Section: "Medicine Reminder" & Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Big Text "Medicine Reminder"
                const Expanded(
                  child: Text(
                    "Medicine Reminder",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 40, // Big text
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                // Medicine Image
                Image.asset(
                  'assets/images/mediPhoto.jpg', // Ensure correct path
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          // Middle Section: Fix Calendar Overlapping Issue
          SizedBox(
            height: 90, // Ensuring calendar doesn't overflow
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text(
                          "Mar ${index + 10}", // Example: Mar 10, Mar 11, ...
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[900],
                          child: Text(
                            "${index + 10}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          // Expanded ListView to Avoid Overflow
          Expanded(
            child: ListView.separated(
              padding:
                  const EdgeInsets.only(top: 10), // Add spacing from calendar
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/medicine.jpeg'),
                  ),
                  title: Text(arrNames[index]),
                  subtitle: Text(arrSubtitles[index]),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicineDetail(
                                medicineName: arrNames[index],
                              )),
                    );
                  },
                );
              },
              itemCount: arrNames.length,
              separatorBuilder: (context, index) {
                return const Divider(height: 100, thickness: 1);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
          // Action when button is clicked
        },
        backgroundColor: Colors.blue[900], // Change color
        child:
            const Icon(Icons.add, size: 30, color: Colors.white), // Plus icon
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Position at bottom-right
    );
  }
}
