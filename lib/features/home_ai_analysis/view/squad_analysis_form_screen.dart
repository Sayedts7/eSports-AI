import 'package:esports/core/constants/MySize.dart';
import 'package:esports/core/constants/colors.dart';
import 'package:esports/core/constants/textStyles.dart';
import 'package:esports/core/custom_widgets/custom_button.dart';
import 'package:esports/core/custom_widgets/custom_textfield.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/auth/model/user_model.dart';
import 'package:esports/features/home_ai_analysis/controller/squad_analysis_controller.dart';
import 'package:esports/features/home_ai_analysis/view/saved_data_squad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquadGameStatsFormScreen extends StatelessWidget {
  final SquadGameStatsController controller = Get.put(SquadGameStatsController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _userController.onInit();
    controller.player1NameController.text = _userController.currentUser?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Squad Game Stats"),
        actions: [
          IconButton(onPressed: (){
            Get.to(() => SavedSquadStatsScreen());

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
              const SizedBox(height: 32),
              _buildPlayerStatsSection("Player 2 Stats", controller.player2NameController,controller.player2KillsController,
                  controller.player2AssistsController, controller.player2DamageController, controller.player2SurvivedController),
              const SizedBox(height: 32),
              _buildPlayerStatsSection("Player 3 Stats", controller.player3NameController,controller.player3KillsController,
                  controller.player3AssistsController, controller.player3DamageController, controller.player3SurvivedController),
              const SizedBox(height: 32),
              _buildPlayerStatsSection("Player 4 Stats", controller.player4NameController,controller.player4KillsController,
                  controller.player4AssistsController, controller.player4DamageController, controller.player4SurvivedController),
              const SizedBox(height: 32),
              _buildPlayerStatsSection("Player 5 Stats (Optional)", controller.player5NameController,controller.player5KillsController,
                  controller.player5AssistsController, controller.player5DamageController, controller.player5SurvivedController),
              const SizedBox(height: 32),
              _buildPlayerStatsSection("Player 6 Stats (Optional)", controller.player6NameController,controller.player6KillsController,
                  controller.player6AssistsController, controller.player6DamageController, controller.player6SurvivedController),
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
            Obx((){
              return   Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MySize.size15,),
                   Text('Chicken Dinner?',
                      style:  AppTextStyles.label16600B),
                  SizedBox(width: MySize.size15,),

                  GestureDetector(
                    onTap: () async {
                      if(controller.isTrue.value == true){
                        controller.updateChickenDinner(false);
                      }else{
                        controller.updateChickenDinner(true );

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: controller.isTrue.value ? primaryColor : Colors.grey,
                          width: 2.0,
                        ),
                        color: controller.isTrue.value? backgroundColor : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: controller.isTrue.value
                            ? const Icon(
                          Icons.check,
                          size: 14.0,
                          color: primaryColor,
                        )
                            : Container(
                          width: 14.0,
                          height: 14.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
              // CustomTextField13(
              //   title: "Chicken Dinner",
              //   controller: controller.teamChickenDinnerController,
              //   keyboardType: TextInputType.number,
              //   hintText: "Enter number of recalls",
              // ),
              const SizedBox(height: 32),
              CustomButton8(
                onPressed: () {
                  // Validate Player 1
                  if (controller.player1NameController.text.isEmpty ||
                      controller.player1KillsController.text.isEmpty ||
                      controller.player1AssistsController.text.isEmpty ||
                      controller.player1DamageController.text.isEmpty ||
                      controller.player1SurvivedController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields for Player 1",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  // Validate Player 2
                  if (controller.player2NameController.text.isEmpty ||
                  controller.player2KillsController.text.isEmpty ||
                      controller.player2AssistsController.text.isEmpty ||
                      controller.player2DamageController.text.isEmpty ||
                      controller.player2SurvivedController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields for Player 2",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  // Validate Player 3
                  if (controller.player3NameController.text.isEmpty ||
                      controller.player3KillsController.text.isEmpty ||
                      controller.player3AssistsController.text.isEmpty ||
                      controller.player3DamageController.text.isEmpty ||
                      controller.player3SurvivedController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields for Player 3",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  // Validate Player 4
                  if (controller.player4NameController.text.isEmpty ||
                      controller.player4KillsController.text.isEmpty ||
                      controller.player4AssistsController.text.isEmpty ||
                      controller.player4DamageController.text.isEmpty ||
                      controller.player4SurvivedController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields for Player 4",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  // Validate Player 4
                  if (controller.teamHealthRestoreController.text.isEmpty ||
                      controller.teamRescuesController.text.isEmpty
                     ) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields for team",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  // If all validations pass
                  controller.addStats();
                },
                text: 'Submit',
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerStatsSection(
      String title,
      TextEditingController nameController,
      TextEditingController killsController,
      TextEditingController assistsController,
      TextEditingController damageController,
      TextEditingController survivedController,

      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        CustomTextField13(
          title: 'Player name',
          controller: nameController,
          keyboardType: TextInputType.text,
          // readOnly: true,
          hintText: "Enter name",
          validator: (value) =>
          value == null || value.isEmpty ? "Field is required" : null,
        ),
        const SizedBox(height: 16),
        CustomTextField13(
          title: "Kills",
          controller: killsController,
          keyboardType: TextInputType.number,
          hintText: "Enter number of kills",
        ),
        const SizedBox(height: 16),
        CustomTextField13(
          title: "Assists",
          controller: assistsController,
          keyboardType: TextInputType.number,
          hintText: "Enter number of assists",
        ),
        const SizedBox(height: 16),
        CustomTextField13(
          title: "Damage",
          controller: damageController,
          keyboardType: TextInputType.number,
          hintText: "Enter damage dealt",
        ),
        const SizedBox(height: 16),
        CustomTextField13(
          title: "Survived",
          controller: survivedController,
          keyboardType: TextInputType.number,
          hintText: "Enter survival time",
        ),
      ],
    );
  }
}
