// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class homepage extends StatefulWidget{
//   @override
//   State<homepage> createState() => _homepageState();
// }

// class _homepageState extends State<homepage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Text("Sign In as "+user.email!,style: TextStyle(height: 30),),
//           ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: WidgetStatePropertyAll(Colors.cyan),
//                 elevation: WidgetStatePropertyAll(10),
//                 shadowColor: WidgetStatePropertyAll(Colors.blue),
//                 overlayColor: WidgetStatePropertyAll(Colors.lightBlue)
//             ),
//             child: Text("Sign Out",style: TextStyle(
//               fontSize: 30,
//               color: Colors.purpleAccent,
//             ),
//             ),
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//           )
//         ],
//       )),
//     );

//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  // ✅ Corrected class name
  @override
  State<homepage> createState() => _homepageState(); // ✅ Corrected here
}

class _homepageState extends State<homepage> {
  // ✅ Match class name
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? prescriptionData;

  @override
  void initState() {
    super.initState();
    fetchPrescription();
  }

  Future<void> fetchPrescription() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('prescriptions')
          .doc('t1ef9z75hiielTGgNwqY') // Firestore document ID
          .get();

      if (doc.exists) {
        setState(() {
          prescriptionData = doc.data() as Map<String, dynamic>;
        });
      } else {
        print("No prescription found.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Signed in as: ${user.email!}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            prescriptionData != null
                ? Column(
                    children: [
                      Text("Medicine Name: ${prescriptionData!['name']}"),
                      Text("Dosage: ${prescriptionData!['dosage']}"),
                      Text("Frequency: ${prescriptionData!['frequency']}"),
                      Text("Duration: ${prescriptionData!['duration']}"),
                      Text("Timestamp: ${prescriptionData!['timestamp']}"),
                    ],
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                elevation: 10,
                shadowColor: Colors.blue,
                foregroundColor: Colors.purpleAccent,
              ),
              child: Text("Sign Out", style: TextStyle(fontSize: 20)),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
