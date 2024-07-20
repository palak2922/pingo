import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingo/Widgets/custom_toast_message.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      CustomToastMessage().showLongToast('Login Successful!!');
      return result.user;
    } catch (e) {
      CustomToastMessage().showLongToast('$e');
      print('Error signing in: $e');
    }
    return null;
  }

  Future<User?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'displayName': name,
          'email': email,
          // 'password': password,
        });
        CustomToastMessage().showLongToast('SignUp Successful.. Please Login!!');
        return user;
      }
    } catch (e) {
      CustomToastMessage().showLongToast('$e');
      print('Error signing up: $e');
    }
    return null;
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
    CustomToastMessage().showLongToast('Logged Out');
  }
}
