import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CommonFunctions {
  static String? validateTextField(value, BuildContext context,String type) {
    if(type == 'email'){
      if (value == null || value.isEmpty) {
        return 'Enter your Email';
      } else if (value.isNotEmpty) {
        String emailOfuser1 = value.toString();
        // final RegExp _emailRegExp = RegExp(
        //   r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        // );
        String pattern = r'\w+@\w+\.\w+';
        if (RegExp(pattern).hasMatch(emailOfuser1) == false) {
          return 'Enter a valid email';
        }
      }
      return null;
    }
    else if(type == 'password'){
      if (value == null || value.isEmpty) {
        return 'Enter password';
      } else if(value.toString().length < 6) {
        return 'Password too short';
      }

    }
    else if(type == 'name'){
      if (value == null || value.isEmpty) {
        return 'Enter your name';
      } else {
        return null;
      }
    }
    else if(type == 'userName'){
      if (value == null || value.isEmpty) {
        return 'Enter  Username';
      } else {
        return null;
      }
    }

    else if(type == 'phone'){
      if (value == null || value.isEmpty) {
        return 'Enter your phone number';
      } else {
        return null;
      }
    }
    else if(type =='project name'){
      if (value == null || value.isEmpty) {
        return 'Enter your project name';
      } else {
        return null;
      }
    }
    else if(type =='date'){
      if (value == null || value.isEmpty) {
        return 'Enter a date';
      } else {
        return null;
      }
    }

  }
// static void loginFailedDialog(BuildContext context, String error, VoidCallback onTap){
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title:  Text(AppLocale.signInFailed.getString(context)),
//         content: Text(error),
//         actions: [
//           TextButton(
//             child:  Text(AppLocale.ok.getString(context)),
//             onPressed: onTap,
//           ),
//         ],
//       );
//     },
//   );
// }

  static void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text('No Internet'),
        content:
        Text('Please Check your internet connection'),
        actions: [
          ElevatedButton(
            child:  Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static Future<bool> isUserBlocked( String uid) async {

    if (uid == null) {
      // Handle case where there is no current user logged in
      return false;
    }

    try {
      // Reference to the document of the current user in the "Clients" collection
      DocumentSnapshot clientSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .get();

      if (clientSnapshot.exists) {
        // Check if the 'blocked' field exists and is true
        bool isBlocked = clientSnapshot.get('isBlocked') ?? false;
        return isBlocked;
      } else {
        // User document does not exist
        return false;
      }
    } catch (e) {
      print('Error checking blocked status: $e');
      return false;
    }
  }



}