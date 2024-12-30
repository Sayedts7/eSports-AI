import 'package:esports/features/auth/controller/auth_controller.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/drawer_controller.dart';

class CustomDrawer extends StatelessWidget {

  final DrawerControllers _drawerController = Get.put(DrawerControllers());
  final UserController _userController = Get.put(UserController());
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header with User Profile
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              accountName: Text(
                _userController.currentUser?.name ?? 'User',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                _userController.currentUser?.email ?? 'user@example.com',
                style: GoogleFonts.roboto(
                  color: Colors.white70,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child:Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),

            // Drawer Items
            // _buildDrawerItem(
            //   icon: Icons.newspaper,
            //   title: 'News',
            //   onTap: _drawerController.navigateToAIGameAnalysis,
            // ),

            _buildDrawerItem(
              icon: Icons.info_outline,
              title: 'App Version',
              onTap: () => _drawerController.showAppVersion(context),
            ),

            _buildDrawerItem(
              icon: Icons.description,
              title: 'Terms & Conditions',
              onTap: () => _drawerController.showTermsAndConditions(context),
            ),

            Divider(color: Colors.white30),

            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: _authController.logoutUser,
              color: Colors.red.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.white,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color ?? Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}