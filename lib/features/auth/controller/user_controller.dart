import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  UserModel? get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      fetchUserDetails(firebaseUser.uid);
    }
  }

  Future<void> fetchUserDetails(String userId) async {
    // print('fetch user is callled $userId');
    try {
      // print('fetch user is callled1');

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      // print('fetch user is callled2');

      // print(userDoc.id);
      if (userDoc.exists) {
        // print('yessssssssssss');
        _currentUser.value = UserModel.fromFirestore(userDoc);
      //   print(_currentUser);
      //   print(_currentUser.value);
      //   print(_currentUser.value?.name);
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  // Method to update user profile
  Future<void> updateUserProfile(UserModel updatedUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());

      _currentUser.value = updatedUser;
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  //create user
  Future<void> createUser(UserModel newUser) async {
    try {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toMap());

      _currentUser.value = newUser;
    } catch (e) {
      print('Error creating user: $e');
    }
  }


  // Clear user data on logout
  void clearUserData() {
    _currentUser.value = null;
  }
}