import 'dart:ui';
import 'package:esports/core/constants/MySize.dart';
import 'package:esports/core/constants/colors.dart';
import 'package:esports/core/constants/image_path.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/home_ai_analysis/view/card_select_screen.dart';
import 'package:esports/features/home_ai_analysis/view/duo_analysis_form_screen.dart';
import 'package:esports/features/home_ai_analysis/view/solo_analysis_form_screen.dart';
import 'package:esports/features/home_ai_analysis/view/squad_analysis_form_screen.dart';
import 'package:esports/features/home_ai_analysis/widget/custom_drawer.dart';
import 'package:esports/features/news/view/news_screen.dart';
import 'package:esports/features/profile/view/my_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController _userController = Get.put(UserController());
  /// Controller to handle bottom nav bar and also handles initial page
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;

  /// Widget list to switch between pages
  final List<Widget> bottomBarPages = [
    const MainHomeContent(),
     NewsScreen(),
     MyProfileView(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildFrostedCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: MySize.size200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                height: MySize.size200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MySize.size34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    _userController.onInit();
    return Scaffold(

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: bottomBarPages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        notchColor: primaryColor,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_outlined, color: primaryColor),
            activeItem: Icon(Icons.home, color: Colors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.newspaper_outlined, color: primaryColor),
            activeItem: Icon(Icons.newspaper, color: Colors.white),
            itemLabel: 'News',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: primaryColor),
            activeItem: Icon(Icons.person, color: Colors.white),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        }, kIconSize: 20, kBottomRadius: 10,
      ),
    );
  }
}

// Main home content moved to separate widget
class MainHomeContent extends StatelessWidget {
  const MainHomeContent({Key? key}) : super(key: key);
  Widget buildFrostedCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: MySize.size200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                height: MySize.size200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MySize.size34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.size16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MySize.size20),
                buildFrostedCard(
                  title: 'Solo',
                  imagePath: solo,
                  onTap: () {
                    Get.to(() => SoloGameStatsFormScreen());
                  },
                ),
                SizedBox(height: MySize.size20),
                buildFrostedCard(
                  title: 'Duo',
                  imagePath: duoo,
                  onTap: () {
                    Get.to(() => DuoGameStatsFormScreen());
                  },
                ),
                SizedBox(height: MySize.size20),
                buildFrostedCard(
                  title: 'Squad',
                  imagePath: squadd,
                  onTap: () {
                    Get.to(() => SquadGameStatsFormScreen());
                  },
                ),
                // Add bottom padding to account for the bottom bar
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

