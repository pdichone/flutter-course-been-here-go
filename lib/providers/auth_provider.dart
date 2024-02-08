import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  Uuid uuid = Uuid();

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String?> uploadImageToFirebase(XFile imageFile) async {
    try {
      // /images/
      //  - dxelfi;883ld..
      // - ourimage2..
      String filename = 'images/${uuid.v4()}';

      //Create a File object from XFile's path
      File file = File(imageFile.path);
      
    } catch (e) {}
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
