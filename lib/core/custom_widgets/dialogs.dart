import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/MySize.dart';
import '../constants/image_path.dart';
import 'custom_button.dart';

void showBlockedUserDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Account Blocked',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your account has been blocked by the admin.\nPlease contact the admin for further assistance.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// void showCompleteProject(BuildContext context, String id) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: SingleChildScrollView(
//           child: Container(
//             width: MySize.size335,
//             // height: 392,
//             decoration: BoxDecoration(
//               color: Color(0xFFFFFFFF),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             padding: EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Image.asset(
//                   projectCreated, // Replace with your image URL
//                   width: MySize.size120,
//                   height: MySize.size120,
//                 ),
//                 SizedBox(height: MySize.size10),
//                 Text(
//                   'Confirmation',
//                   style: TextStyle(
//                       fontSize: MySize.size20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: MySize.size8),
//                 Text(
//                   'Would you like to Complete this Project?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: MySize.size16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     CustomBorderedButton(
//                         width: 120,
//                         height: 40,
//                         text: 'Cancel',
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         }),
//                     CustomButton8(
//                       width: 120,
//                       height: 40,
//                       onPressed: () {
//                         FirebaseFirestore.instance
//                             .collection('Projects')
//                             .doc(id)
//                             .update({
//                           'status': 'Completed',
//                         }).then((value) {
//                           Utils.toastMessage('Completed');
//                           Navigator.pop(context);
//                         }).onError((error, stackTrace) {
//                           Utils.toastMessage(error.toString());
//                         });
//                       },
//                       text: 'Yes',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// void showProjectUploadDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return WillPopScope(
//         onWillPop: () async {
//           // Return false to prevent dialog from being closed
//           return false;
//         },
//         child: Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Container(
//               width: MySize.size335,
//               // height: 392,
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFFFFF),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Image.asset(
//                     projectCreated, // Replace with your image URL
//                     width: MySize.size120,
//                     height: MySize.size120,
//                   ),
//                   SizedBox(height: MySize.size10),
//                   Text(
//                     'Congratulations',
//                     style: TextStyle(
//                         fontSize: MySize.size20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: MySize.size8),
//                   Text(
//                     'Your order has been placed. Please wait as your order is being processed.\n'
//                         'Hang tight while we get everyhing ready for you',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: MySize.size16),
//                   CustomButton8(
//                     // width:120,
//                     height: 40,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeView()));
//                     },
//                     text: 'Close',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }


