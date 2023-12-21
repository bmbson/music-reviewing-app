// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addComment(FirebaseAuth auth, FirebaseFirestore db, String albumName,
    String albumImage, String artistName, String comment, String userName) {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);

  var reviewInfo = {
    "comment": comment,
    "userName": userName,
    "date": date.toString()
  };

  db.collection('albums').doc(albumName).collection('comments').add(reviewInfo);
}
