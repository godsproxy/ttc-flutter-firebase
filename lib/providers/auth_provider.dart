import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthState { unknown, authenticated, unauthenticated }

class MyAuthProvider extends ChangeNotifier {
  // enum to keep track of auth state
  AuthState _authState = AuthState.unknown;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // update auth state
  void updateAuthState(User? event) {
    if (event != null) {
      _authState = AuthState.authenticated;
      notifyListeners();
    } else {
      _authState = AuthState.unauthenticated;
      notifyListeners();
    }
  }
}
