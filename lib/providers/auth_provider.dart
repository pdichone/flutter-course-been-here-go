import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signInUserAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      //handle the error
      print('${e.message}');
    }
  }
}
