import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/getCurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void deleteBookmark(FirebaseAuth auth, FirebaseFirestore db, String albumName,
    String artistName, String albumImage) async {
  String email = getCurrentUserEmail(auth);
  try {
    await db
        .collection('users')
        .doc(email)
        .collection('bookmarks')
        .where('albumName', isEqualTo: albumName)
        // .where('artistName', isEqualTo: artistName)
        // .where('albumImage', isEqualTo: albumImage)
        .get()
        .then((value) => value.docs.forEach((element) {
              db
                  .collection('users')
                  .doc(email)
                  .collection("bookmarks")
                  .doc(element.id)
                  .delete()
                  .then((value) {
              });
            }));
  } catch (e) {
    debugPrint("Error completing: $e");
  }
}
