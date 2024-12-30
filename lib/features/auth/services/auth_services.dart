import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

import '../../../core/utils.dart';


class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "YOUR_GOOGLE_CLIENT_ID", // Replace with your Google Client ID
  );
  final firestore = FirebaseFirestore.instance.collection('User');

  /// Sign in with Email and Password
  Future<UserCredential?> signInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print(e);
      _handleAuthError(context, e);

      return null;
    }
  }

  /// Sign up with Email and Password
  Future<UserCredential?> signUpWithEmail(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();
      return userCredential;
    } catch (e) {
      _handleAuthError(context, e);
      return null;
    }
  }

  /// Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      try {
        return await _auth.signInWithPopup(googleProvider);
      } catch (e) {
        print('Google Sign-In Error (Web): $e');
        return null;
      }
    } else {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await _auth.signInWithCredential(credential);
      } catch (e) {
        print('Google Sign-In Error (Mobile): $e');
        return null;
      }
    }
  }

  /// Apple Sign-In
  // Future<UserCredential?> signInWithApple() async {
  //   final rawNonce = _generateNonce();
  //   final nonce = _sha256ofString(rawNonce);
  //
  //   try {
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );
  //
  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       rawNonce: rawNonce,
  //     );
  //     return await _auth.signInWithCredential(oauthCredential);
  //   } catch (e) {
  //     print("Apple Sign-In Error: $e");
  //     return null;
  //   }
  // }

  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Reset Password Error: $e');
    }
  }

  /// Update Password
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      print('Password updated successfully');
    } catch (e) {
      print('Update Password Error: $e');
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
    } catch (e) {
      print('Sign-Out Error: $e');
    }
  }

  /// Store User Data
  Future<void> setData(String email, String name) async {
    try {
      final DocumentReference parentDocument = firestore.doc(_auth.currentUser!.uid);

      await parentDocument.set({
        'id': _auth.currentUser!.uid,
        'name': name,
        'email': email,
        'status': 'Active',
        'createdAt': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('Permission denied: $e');
        Utils.toastMessage('You do not have permission to perform this action.');
      } else if (e.code == 'unavailable') {
        print('Firestore unavailable: $e');
        Utils.toastMessage('Service unavailable. Please try again later.');
      } else {
        print('Unknown Firestore error: $e');
        Utils.toastMessage('An error occurred while saving data.');
      }
    } catch (e) {
      print('Unexpected error: $e');
      Utils.toastMessage('An unexpected error occurred. Please try again.');
    }
  }


  /// Error Handling
  void _handleAuthError(BuildContext context, dynamic e) {
    if (e is FirebaseAuthException) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid Email';
          break;
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong Password';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email already in use';
          break;
        default:
          errorMessage = e.message ?? 'Authentication error';
      }

      _showErrorDialog(context, errorMessage);
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Nonce Generation for Apple Sign-In
  String _generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
