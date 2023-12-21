import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<List<Map<dynamic, dynamic>>> getAlbumComments(
  FirebaseAuth auth,
  FirebaseFirestore db,
  String albumName,
) async {
  List<Map<dynamic, dynamic>> list = [];

  try {
    var querySnapshot = await db
        .collection('albums')
        .doc(albumName)
        .collection('comments')
        .get();
    list = querySnapshot.docs.map((doc) => doc.data()).toList();
    return list;
  } catch (e) {
    debugPrint("Error completing: $e");
    return [];
  }
}
