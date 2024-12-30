// my_profile_controller.dart
import 'package:esports/core/utils.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfileController extends GetxController {
  RxBool isEditing = false.obs;
  RxBool isLoading = false.obs;
  RxString? name = ''.obs;
  RxString? email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void updateName(String newName) {
    name?.value = newName;
  }

  Future<void> getUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      name?.value = userData.data()?['name'] ?? '';
      email?.value = userData.data()?['email'] ?? '';
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> updateUserProfile() async {
    try {
      isLoading.value = true;
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'name': name?.value,
      });

      toggleEditing();
      Utils.toastMessage('Updated');
    } catch (error) {
      Utils.toastMessage(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
