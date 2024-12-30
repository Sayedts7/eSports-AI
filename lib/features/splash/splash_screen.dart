
import 'dart:ui';

import 'package:esports/features/splash/splash_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    // Initialize the Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3 ), // Adjust duration for animation speed
    )..repeat(reverse: false);
    splashServices.isLogin(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              splash, // Replace with your splash screen image path
              fit: BoxFit.cover,
            ),
          ),
          // Loading Bar at the Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Linear Progress Bar

                  // Frosted Glass Text
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 250,
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Frost effect color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Center(
                        child:
                        // Column(
                        //   children: [
                            // Text(
                            //   'eSports Arena',
                            //   style: TextStyle(
                            //     color: Colors.white, // Text color
                            //     fontSize: 26,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // SizedBox(height: 20),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 2,color: Colors.orange)
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _animationController.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange, // Loading bar color
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          // ],
                        // ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 10),
                  // // Frosted Glass Text
                  // Container(
                  //   clipBehavior: Clip.hardEdge,
                  //   width: 150,
                  //   height: 40,
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 8.0, horizontal: 16.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.1), // Frost effect color
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: BackdropFilter(
                  //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  //     child: Center(
                  //       child: Text(
                  //         'Loading...',
                  //         style: TextStyle(
                  //           color: Colors.white, // Text color
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

