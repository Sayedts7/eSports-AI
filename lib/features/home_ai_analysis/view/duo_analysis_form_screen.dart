import 'package:esports/core/custom_widgets/custom_button.dart';
import 'package:esports/core/custom_widgets/custom_textfield.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/home_ai_analysis/controller/duo_analysis_controller.dart';
import 'package:esports/features/home_ai_analysis/view/saved_data_duo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DuoGameStatsFormScreen extends StatelessWidget {
  final DuoGameStatsController controller = Get.put(DuoGameStatsController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _userController.onInit();
    controller.player1NameController.text = _userController.currentUser?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Duo Game Stats"),
        actions: [
          IconButton(onPressed: (){
            Get.to(() => SavedDuoStatsScreen());

          }, icon: Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Player 1 Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title:  'Name',
                controller: controller.player1NameController,
                keyboardType: TextInputType.text,
                // readOnly: true,
                hintText: "Enter name",
                validator: (value) =>
                value == null || value.isEmpty ? "Field is required" : null,
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Kills",
                controller: controller.player1KillsController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of kills",
                validator: (value) =>
                value == null || value.isEmpty ? "Field is required" : null,
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Assists",
                controller: controller.player1AssistsController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of assists",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Damage",
                controller: controller.player1DamageController,
                keyboardType: TextInputType.number,
                hintText: "Enter damage dealt",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Survived",
                controller: controller.player1SurvivedController,
                keyboardType: TextInputType.number,
                hintText: "Enter survival time",
              ),
              // const SizedBox(height: 16),
              // CustomTextField13(
              //   title: "Ratings",
              //   controller: controller.player1RatingsController,
              //   keyboardType: TextInputType.number,
              //   hintText: "Enter player rating",
              // ),
              const SizedBox(height: 32),
              const Text(
                "Player 2 Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title:  'Name',
                controller: controller.player2NameController,
                keyboardType: TextInputType.text,
                // readOnly: true,
                hintText: "Enter name",
                validator: (value) =>
                value == null || value.isEmpty ? "Field is required" : null,
              ),
              const SizedBox(height: 16),

              CustomTextField13(
                title: "Kills",
                controller: controller.player2KillsController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of kills",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Assists",
                controller: controller.player2AssistsController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of assists",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Damage",
                controller: controller.player2DamageController,
                keyboardType: TextInputType.number,
                hintText: "Enter damage dealt",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Survived",
                controller: controller.player2SurvivedController,
                keyboardType: TextInputType.number,
                hintText: "Enter survival time",
              ),
              // const SizedBox(height: 16),
              // CustomTextField13(
              //   title: "Ratings",
              //   controller: controller.player2RatingsController,
              //   keyboardType: TextInputType.number,
              //   hintText: "Enter player rating",
              // ),
              const SizedBox(height: 32),
              const Text(
                "Team Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Health Restored",
                controller: controller.teamHealthRestoreController,
                keyboardType: TextInputType.number,
                hintText: "Enter health restored",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Rescues",
                controller: controller.teamRescuesController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of rescues",
              ),
              const SizedBox(height: 16),
              CustomTextField13(
                title: "Recalls",
                controller: controller.teamRecallsController,
                keyboardType: TextInputType.number,
                hintText: "Enter number of recalls",
              ),
              const SizedBox(height: 32),
              CustomButton8(
                onPressed: controller.addStats,
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
