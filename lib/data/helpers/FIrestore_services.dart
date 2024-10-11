import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference collection = FirebaseFirestore.instance.collection(
      'favorite_collection');

  Future<void> adduser(Map<String, dynamic> users) async {
    await collection.add(users);
  }

  // Stream<QuerySnapshot> getuser() {
  //   return collection.snapshots();
  // }

  Future<void> updateuser(String id, Map<String, dynamic> users) async {
    await collection.doc(id).update(users);
  }

  Future<void> deleteuser(String id) async {
    await collection.doc(id).delete();
  }

  Stream<List<Map<String, dynamic>>> getuser() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Include the document ID in the data
        return data;
      }).toList();
    });
  }
}