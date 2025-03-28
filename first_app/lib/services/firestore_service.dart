import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference prescriptions =
      FirebaseFirestore.instance.collection('prescriptions');

  // Updated Function with 'duration' parameter
  Future<void> addPrescription(
      String name, String dosage, String frequency, String duration) async {
    await prescriptions.add({
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration, // Added this field
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getPrescriptions() {
    return prescriptions.orderBy('timestamp', descending: true).snapshots();
  }
}
