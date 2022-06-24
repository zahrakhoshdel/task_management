import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
//colection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData({
    required String email,
    required String name,
    required var birthdate,
  }) async {
    return await usersCollection
        .doc(uid)
        .set({'usernam': name, 'email': email, 'birthdate': birthdate});
  }
}
