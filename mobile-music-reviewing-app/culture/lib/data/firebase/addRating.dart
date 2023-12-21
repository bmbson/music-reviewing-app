import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/getCurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addRating(FirebaseAuth auth, FirebaseFirestore db, String albumName,
    String albumImage, String artistName, String ratingNumber) {
  String email = getCurrentUserEmail(auth);

  var albumInfo = <String, String>{
    "albumName": albumName,
    "albumImage": albumImage,
    "artistName": artistName,
  };

  db.collection('users').doc(email).collection(ratingNumber).add(albumInfo);
}
