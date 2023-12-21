import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/getCurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<dynamic, dynamic>>> getUserBookmark(
  FirebaseAuth auth,
  FirebaseFirestore db,
) async {
  String email = getCurrentUserEmail(auth);
  List<Map<dynamic, dynamic>> list = [];

  try {
    var querySnapshot =
        await db.collection('users').doc(email).collection('bookmarks').get();
    list = querySnapshot.docs.map((doc) => doc.data()).toList();
    return list;
  } catch (e) {
    print("Error completing: $e");
    return [];
  }
}
