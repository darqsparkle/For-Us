// import 'package:firebase_auth/firebase_auth.dart';

// class AuthServices {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   User? _user;
//   User? get user {
//     return _user;
//   }

//   AuthServices() {
//     _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
//   }
//   Future<bool> login(String email, String password) async {
//     try {
//       final credential = await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       if (credential.user != null) {
//         _user = credential.user;
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

//   Future<bool> signup(String email, String password) async {
//     try {
//       final credential = await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (credential.user != null) {
//         _user = credential.user;
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

//   Future<bool> logout() async {
//     try {
//       await _firebaseAuth.signOut();
//       return true;
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

//   void authStateChangesStreamListener(User? user) {
//     if (user != null) {
//       _user = user;
//     } else {
//       _user = null;
//     }
//   }
// }
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  User? _user;
  User? get user {
    return _user;
  }

  AuthServices() {
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print("Login error: $e");
    }
    return false;
  }

  Future<bool> signup(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print("Signup error: $e");
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Logout error: $e");
    }
    return false;
  }

  Future<bool> uploadProfileImage(File image, String email) async {
    try {
      final storageRef = _firebaseStorage.ref().child('profile_images/$email');
      await storageRef.putFile(image);
      return true;
    } catch (e) {
      print("Profile image upload error: $e");
    }
    return false;
  }

  void authStateChangesStreamListener(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }
}
