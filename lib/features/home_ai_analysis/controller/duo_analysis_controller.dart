// import 'package:esports/features/home_ai_analysis/services/gpt_services.dart';
// import 'package:esports/features/home_ai_analysis/view/analysis_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
//
// class DuoGameStatsController extends GetxController {
//   final player1KillsController = TextEditingController();
//   final player1AssistsController = TextEditingController();
//   final player1DamageController = TextEditingController();
//   final player1SurvivedController = TextEditingController();
//
//   final player2KillsController = TextEditingController();
//   final player2AssistsController = TextEditingController();
//   final player2DamageController = TextEditingController();
//   final player2SurvivedController = TextEditingController();
//
//   final teamHealthRestoreController = TextEditingController();
//   final teamRescuesController = TextEditingController();
//   final teamRecallsController = TextEditingController();
//   final player1RatingsController = TextEditingController();
//   final player2RatingsController = TextEditingController();
//
//   late String query;
//
//   Future<void> submitForm() async {
//     try {
//       double player1Kills = double.parse(player1KillsController.text);
//       double player1Assists = double.parse(player1AssistsController.text);
//       double player1Damage = double.parse(player1DamageController.text);
//       double player1Survived = double.parse(player1SurvivedController.text);
//       double player1Ratings = double.parse(player1RatingsController.text);
//
//
//       double player2Kills = double.parse(player2KillsController.text);
//       double player2Assists = double.parse(player2AssistsController.text);
//       double player2Damage = double.parse(player2DamageController.text);
//       double player2Survived = double.parse(player2SurvivedController.text);
//       double player2Ratings = double.parse(player2RatingsController.text);
//
//       double teamHealthRestore = double.parse(teamHealthRestoreController.text);
//       double teamRescues = double.parse(teamRescuesController.text);
//       double teamRecalls = double.parse(teamRecallsController.text);
//
//       String query = "I recently played a duo game and want to improve my performance. Here are the stats:"
//       "\nPlayer 1 - Kills: $player1Kills, Assists: $player1Assists, Damage: $player1Damage, Survived Time: $player1Survived, Ratings: $player1Ratings."
//       "\nPlayer 2 - Kills: $player2Kills, Assists: $player2Assists, Damage: $player2Damage, Survived Time: $player2Survived, Ratings: $player2Ratings."
//       "\nTeam Stats - Health Restored: $teamHealthRestore, Rescues: $teamRescues, Recalls: $teamRecalls,"
//       "\nCan you provide actionable feedback on how we can improve as a duo, including coordination, positioning, and combat strategy?";
//
//       // Call API or navigate to response screen
//
//       // Show loading indicator
//       Get.dialog(
//         Center(child: CircularProgressIndicator()),
//         barrierDismissible: false,
//       );
//
//       // Send API request
//       String response = await GptServices().sendMsg(query);
//
//       // Navigate to the result screen
//       Get.back(); // Close loading dialog
//       Get.to(() => ResponseScreen(response: response));
//
//
//       // Get.snackbar(
//       //   "Success",
//       //   "Form submitted successfully!",
//       //   snackPosition: SnackPosition.BOTTOM,
//       // );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Please enter valid numeric values for all fields.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // @override
//   // void onClose() {
//   //   killsController1.dispose();
//   //   assistsController1.dispose();
//   //   damageController1.dispose();
//   //   survivedController1.dispose();
//   //   healthRestoreController1.dispose();
//   //   rescuesController.dispose();
//   //   recallsController.dispose();
//   //   ratingsController.dispose();
//   //   super.onClose();
//   // }
// }
import 'package:esports/features/home_ai_analysis/services/gpt_services.dart';
import 'package:esports/features/home_ai_analysis/view/analysis_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DuoGameStatsController extends GetxController {
  final player1NameController = TextEditingController();

  final player1KillsController = TextEditingController();
  final player1AssistsController = TextEditingController();
  final player1DamageController = TextEditingController();
  final player1SurvivedController = TextEditingController();
  // final player1RatingsController = TextEditingController();

  final player2NameController = TextEditingController();
  final player2KillsController = TextEditingController();
  final player2AssistsController = TextEditingController();
  final player2DamageController = TextEditingController();
  final player2SurvivedController = TextEditingController();
  // final player2RatingsController = TextEditingController();

  final teamHealthRestoreController = TextEditingController();
  final teamRescuesController = TextEditingController();
  final teamRecallsController = TextEditingController();

  final RxList<Map<String, dynamic>> statsList = <Map<String, dynamic>>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _loadStatsFromStorage();
  }

  Future<void> _loadStatsFromStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final String? storedData = _prefs.getString('duo_game_stats');
    if (storedData != null) {
      statsList.value = List<Map<String, dynamic>>.from(json.decode(storedData));
    }
  }

  Future<void> _saveStatsToStorage() async {
    await _prefs.setString('duo_game_stats', json.encode(statsList));
  }

  void addStats() {
    final Map<String, dynamic> stats = {
      'player1': {
        'name': player1NameController.text,
        'kills': player1KillsController.text,
        'assists': player1AssistsController.text,
        'damage': player1DamageController.text,
        'survived': player1SurvivedController.text,
        // 'ratings': player1RatingsController.text,
      },
      'player2': {
        'name': player2NameController.text,
        'kills': player2KillsController.text,
        'assists': player2AssistsController.text,
        'damage': player2DamageController.text,
        'survived': player2SurvivedController.text,
        // 'ratings': player2RatingsController.text,
      },
      'team': {
        'healthRestore': teamHealthRestoreController.text,
        'rescues': teamRescuesController.text,
        'recalls': teamRecallsController.text,
      }
    };
    statsList.add(stats);
    _saveStatsToStorage();
    clearForm();
  }

  void deleteStats(int index) {
    statsList.removeAt(index);
    _saveStatsToStorage();
  }

  void clearForm() {
    player1KillsController.clear();
    player1AssistsController.clear();
    player1DamageController.clear();
    player1SurvivedController.clear();
    // player1RatingsController.clear();

    player2KillsController.clear();
    player2AssistsController.clear();
    player2DamageController.clear();
    player2SurvivedController.clear();
    // player2RatingsController.clear();

    teamHealthRestoreController.clear();
    teamRescuesController.clear();
    teamRecallsController.clear();
  }

  void analyzeData() async {
    final List<Map<String, dynamic>> dataToAnalyze = statsList.take(10).toList();

    String query = "I have played several duo games. Here are our stats:\n";
    for (var i = 0; i < dataToAnalyze.length; i++) {
      final game = dataToAnalyze[i];
      query += """
      Game ${i + 1}:
      Player 1(name:  ${game['player1']['name']}) - Kills: ${game['player1']['kills']}, Assists: ${game['player1']['assists']}, Damage: ${game['player1']['damage']}, Survived: ${game['player1']['survived']}
       
      Player 2(name:  ${game['player2']['name']}) - Kills: ${game['player2']['kills']}, Assists: ${game['player2']['assists']}, Damage: ${game['player2']['damage']}, Survived: ${game['player2']['survived']}
      Team Stats - Health Restored: ${game['team']['healthRestore']}, Rescues: ${game['team']['rescues']}, Recalls: ${game['team']['recalls']}
      """;
    }
    query += "Based on these stats, provide actionable feedback for improving our duo gameplay, including coordination, positioning, and combat strategy and also let us know what player contributes how much to the team, add a line in the end telling which player is the best and which the worst.";

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      String response = await GptServices().sendMsg(query);
      Get.back();
      Get.to(() => ResponseScreen(response: response));
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    player1KillsController.dispose();
    player1AssistsController.dispose();
    player1DamageController.dispose();
    player1SurvivedController.dispose();
    // player1RatingsController.dispose();

    player2KillsController.dispose();
    player2AssistsController.dispose();
    player2DamageController.dispose();
    player2SurvivedController.dispose();
    // player2RatingsController.dispose();

    teamHealthRestoreController.dispose();
    teamRescuesController.dispose();
    teamRecallsController.dispose();
    super.onClose();
  }
}