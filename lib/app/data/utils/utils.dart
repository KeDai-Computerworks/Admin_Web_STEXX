import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model_ste.dart';

class Utils {
  static final firebaseFirestore = FirebaseFirestore.instance;
  static const usersCollection = "users_2024";
  static Stream<DocumentSnapshot<SteModel>> userLogin(String id) {
    return firebaseFirestore
        .collection(usersCollection)
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              SteModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }
}
