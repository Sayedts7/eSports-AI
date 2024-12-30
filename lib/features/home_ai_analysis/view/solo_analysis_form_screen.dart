import 'package:esports/core/custom_widgets/custom_button.dart';
import 'package:esports/core/custom_widgets/custom_textfield.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/home_ai_analysis/controller/solo_analysis_controller.dart';
import 'package:esports/features/home_ai_analysis/view/saved_data_solo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoloGameStatsFormScreen extends StatelessWidget {
  final GameStatsController controller = Get.put(GameStatsController());

  SoloGameStatsFormScreen({Key? key}) : super(key: key);
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _userController.onInit();
    controller.nameController.text = _userController.currentUser?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Stats Form"),
        actions: [
          IconButton(onPressed: (){
            Get.to(() => SavedGameStatsScreen());

          }, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomTextField13(
                  title:  'Name',
                  controller: controller.nameController,
                  keyboardType: TextInputType.text,
                  // readOnly: true,
                  hintText: "Enter name",
                  validator: (value) =>
                  value == null || value.isEmpty ? "Field is required" : null,
                ),
                const SizedBox(height: 16),
                CustomTextField13(
                  title: "Kills",
                  controller: controller.killsController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter number of kills",
                  validator: (value) =>
                  value == null || value.isEmpty ? "Field is required" : null,
                ),
                // const SizedBox(height: 16),
                // CustomTextField13(
                //   title: "Assists",
                //   controller: controller.assistsController,
                //   keyboardType: TextInputType.number,
                //   hintText: "Enter number of assists",
                // ),
                const SizedBox(height: 16),
                CustomTextField13(
                  title: "Damage",
                  controller: controller.damageController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter damage dealt",
                ),
                const SizedBox(height: 16),
                CustomTextField13(
                  title: "Survived",
                  controller: controller.survivedController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter survival time",
                ),
                const SizedBox(height: 16),
                CustomTextField13(
                  title: "Health Restore",
                  controller: controller.healthRestoreController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter health restored",
                ),
                // const SizedBox(height: 16),
                // CustomTextField13(
                //   title: "Rescues",
                //   controller: controller.rescuesController,
                //   keyboardType: TextInputType.number,
                //   hintText: "Enter number of rescues",
                // ),
                // const SizedBox(height: 16),
                // CustomTextField13(
                //   title: "Recalls",
                //   controller: controller.recallsController,
                //   keyboardType: TextInputType.number,
                //   hintText: "Enter number of recalls",
                // ),
                const SizedBox(height: 16),
                CustomTextField13(
                  title: "Ratings",
                  controller: controller.ratingsController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter player rating",
                ),
                const SizedBox(height: 32),
                CustomButton8(
                  onPressed: (){


                     controller.addStats();
                  },
                  text: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
