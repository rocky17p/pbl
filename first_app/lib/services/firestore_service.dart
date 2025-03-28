import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a prescription under the user's ID
  Future<void> addPrescription(
      String name, String dosage, String frequency, String duration, String timing) async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      print("User ID: $userId");
      print("Firestore path: /users/$userId/prescriptions");

      // Ensure the user document exists before adding prescriptions
      DocumentReference userDoc = _firestore.collection('users').doc(userId);

      await userDoc.set({
        'email': user.email,
        'uid': userId
      }, SetOptions(merge: true)); // Ensures user document exists

      await userDoc.collection('prescriptions').add({
        'name': name,
        'dosage': dosage,
        'frequency': frequency,
        'duration': duration,
        'timing': timing,  // NEW FIELD ADDED
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Prescription added successfully!");
    } else {
      print("User is not logged in!");
      throw Exception("User not logged in");
    }
  }

  // Function to get prescriptions for the current user
  Stream<QuerySnapshot> getPrescriptions() {
    User? user = _auth.currentUser;

    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('prescriptions')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      print("User is not logged in!");
      throw Exception("User not logged in");
    }
  }
}
