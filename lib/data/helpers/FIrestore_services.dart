import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference collection = FirebaseFirestore.instance.collection('items');

  Future<void> adduser(Map<String, dynamic> item) async {
    await collection.add(item);
  }

  Stream<QuerySnapshot> getuser() {
    return collection.snapshots();
  }

  Future<void> updateuser(String id, Map<String, dynamic> item) async {
    await collection.doc(id).update(item);
  }

  Future<void> deleteuser(String id) async {
    await collection.doc(id).delete();
  }
}