import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/auth/model/user_model.dart';
import 'package:esports/features/auth/view/login_view.dart';
import 'package:esports/features/home_ai_analysis/view/card_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_function.dart';
import '../../../core/custom_widgets/dialogs.dart';
import '../../../core/utils.dart';
import '../services/auth_services.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());

  // Form keys and focus nodes
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final FocusNode loginEmailFocusNode = FocusNode();
  final FocusNode loginPasswordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final FocusNode confirmPasswordFocusNode = FocusNode();

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Observable variables
  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;
  RxBool isObscure = true.obs;
  RxBool isConfirmObscure = true.obs;
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  UserModel? get currentUser => _currentUser.value;

  final AuthServices _authService = AuthServices();

  // Dispose resources
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  // Login function
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      String email = loginEmailController.text;
      String password = loginPasswordController.text;

      bool isConnected = GetPlatform.isWeb ? true : await Utils.checkInternetConnection();

      if (isConnected) {
        try {
          final userCredential = await _authService.signInWithEmail(Get.context!, email, password);
          if (userCredential != null) {
            // Fetch user details
            await _userController.fetchUserDetails(userCredential.user!.uid);

            bool? userBlocked = await CommonFunctions.isUserBlocked(userCredential.user!.uid);

            if (userBlocked) {
              showBlockedUserDialog(Get.context!);
              await _authService.signOut();
              _userController.clearUserData();
            } else {
              Get.offAll(() => HomeScreen());
            }
          }
        } catch (e) {
          // Show the error message returned from the AuthService
          if (e is String) {
            Utils.toastMessage(e); // Or display it as a dialog if preferred
          } else {
            Utils.toastMessage('An unexpected error occurred.');
          }
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        CommonFunctions.showNoInternetDialog(Get.context!);
      }
    }
  }
  // Signup function
  Future<void> signup() async {
    if (signupFormKey.currentState!.validate()) {
      isLoading.value = true;
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (password != confirmPassword) {
        Utils.toastMessage('Passwords do not match');
        isLoading.value = false;
        return;
      }

      bool isConnected = GetPlatform.isWeb ? true : await Utils.checkInternetConnection();

      if (isConnected) {
        try {
          final userCredential = await _authService.signUpWithEmail(Get.context!, email, password);

          if (userCredential != null) {
            // Create a new UserModel
            final UserModel newUser = UserModel(
              id: userCredential.user!.uid,
              name: name,
              email: email,
              createdAt: DateTime.now() ,
            );

            // Store user data in Firestore using the UserController
            await _userController.createUser(newUser);
            Utils.toastMessage('Signup successful!');
            Get.offAll(() => HomeScreen());
          } else {
            Utils.toastMessage('Signup failed');
          }
        } catch (e) {
          Utils.toastMessage(e.toString());
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        CommonFunctions.showNoInternetDialog(Get.context!);
      }
    }
  }

  // Forgot password function
  Future<void> forgotPassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      String email = emailController.text;

      bool isConnected = GetPlatform.isWeb ? true : await Utils.checkInternetConnection();

      if (isConnected) {
        try {
          await _authService.resetPassword( email);
          Utils.toastMessage('Password reset email sent');
        } catch (e) {
          Utils.toastMessage(e.toString());
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        CommonFunctions.showNoInternetDialog(Get.context!);
      }
    }
  }

  //Logout function
  Future<void> logoutUser() async {
    try {
      await _authService.signOut().then((value) {
        Get.offAll(() => LoginView()); // Replace `LoginScreen` with your desired screen.
      });
    } catch (e) {
      Utils.toastMessage('Error logging out: $e');
    }
  }


  // Toggle visibility for password fields
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleConfirmObscure() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }
}


// Platform  Firebase App Id
// web       1:161407649420:web:cfb3d281cb0a779ee71da9
// android   1:161407649420:android:f79822a957f4082ee71da9
// ios       1:161407649420:ios:40625be8c9ef78a4e71da9
// macos     1:161407649420:ios:40625be8c9ef78a4e71da9
// windows   1:161407649420:web:49b299669b7d5f07e71da9
