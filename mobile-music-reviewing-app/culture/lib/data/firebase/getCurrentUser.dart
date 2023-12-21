import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

getCurrentUserEmail(auth) {
  final user = auth.currentUser!.email;
  return user;
}
