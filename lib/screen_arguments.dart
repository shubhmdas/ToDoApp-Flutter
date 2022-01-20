import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScreenArguments {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;

  ScreenArguments(this.auth, this.firestore);
}