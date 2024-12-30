import 'package:esports/features/news/view/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerControllers extends GetxController {
    String appName= 'eSports Edge';
    String packageName= 'com.example.newsapp';
    String version= '1.0.0';
    String buildNumber= '1';


  void showAppVersion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'App Version',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Name: ${appName}',
              style: GoogleFonts.roboto(),
            ),
            Text(
              'Version: ${version}',
              style: GoogleFonts.roboto(),
            ),
            Text(
              'Build Number: ${buildNumber}',
              style: GoogleFonts.roboto(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. User Agreement',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'By using this app, you agree to our terms of service.',
                style: GoogleFonts.roboto(),
              ),
              SizedBox(height: 10),
              Text(
                '2. Privacy Policy',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We protect your data and ensure privacy.',
                style: GoogleFonts.roboto(),
              ),
              // Add more terms as needed
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }



  // void navigateToAIGameAnalysis() {
  //   Get.to(() => NewsScreen());
  // }
}