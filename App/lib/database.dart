import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getHeartChart() async {
    return Firestore.instance
        .collection("devices")
        .document("nerve_0")
        .collection("measurements")
        .orderBy("timestamp")
        .snapshots();
  }

  getTimeNew() async {
    return Firestore.instance
        .collection("devices")
        .document("nerve_0")
        .collection("measurements")
        .orderBy("timestamp", descending: true)
        .getDocuments();
  }
}
