import 'dart:convert';

import 'package:esports/features/home_ai_analysis/services/gpt_services.dart';
import 'package:esports/features/home_ai_analysis/view/analysis_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SquadGameStatsController extends GetxController {
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
//   final player3KillsController = TextEditingController();
//   final player3AssistsController = TextEditingController();
//   final player3DamageController = TextEditingController();
//   final player3SurvivedController = TextEditingController();
//
//   final player4KillsController = TextEditingController();
//   final player4AssistsController = TextEditingController();
//   final player4DamageController = TextEditingController();
//   final player4SurvivedController = TextEditingController();
//
//   final teamHealthRestoreController = TextEditingController();
//   final teamRescuesController = TextEditingController();
//   final teamRecallsController = TextEditingController();
//
//   late String query;
//
//   Future<void> submitForm() async {
//     try {
//       // Parse Player 1 Stats
//       double player1Kills = double.parse(player1KillsController.text);
//       double player1Assists = double.parse(player1AssistsController.text);
//       double player1Damage = double.parse(player1DamageController.text);
//       double player1Survived = double.parse(player1SurvivedController.text);
//       // double player1Ratings = double.parse(player1RatingsController.text);
//
//       // Parse Player 2 Stats
//       double player2Kills = double.parse(player2KillsController.text);
//       double player2Assists = double.parse(player2AssistsController.text);
//       double player2Damage = double.parse(player2DamageController.text);
//       double player2Survived = double.parse(player2SurvivedController.text);
//       // double player2Ratings = double.parse(player2RatingsController.text);
//
//       // Parse Player 3 Stats
//       double player3Kills = double.parse(player3KillsController.text);
//       double player3Assists = double.parse(player3AssistsController.text);
//       double player3Damage = double.parse(player3DamageController.text);
//       double player3Survived = double.parse(player3SurvivedController.text);
//       // double player3Ratings = double.parse(player3RatingsController.text);
//
//       // Parse Player 4 Stats
//       double player4Kills = double.parse(player4KillsController.text);
//       double player4Assists = double.parse(player4AssistsController.text);
//       double player4Damage = double.parse(player4DamageController.text);
//       double player4Survived = double.parse(player4SurvivedController.text);
//       // double player4Ratings = double.parse(player4RatingsController.text);
//
//       // Parse Team Stats
//       double teamHealthRestore = double.parse(teamHealthRestoreController.text);
//       double teamRescues = double.parse(teamRescuesController.text);
//       double teamRecalls = double.parse(teamRecallsController.text);
//
//       // Construct the query
//       String query = "I recently played a squad game and want to improve our performance. Here are the stats:"
//           "\nPlayer 1 - Kills: $player1Kills, Assists: $player1Assists, Damage: $player1Damage, Survived Time: $player1Survived,"
//           // " Ratings: $player1Ratings."
//           "\nPlayer 2 - Kills: $player2Kills, Assists: $player2Assists, Damage: $player2Damage, Survived Time: $player2Survived, "
//           // "Ratings: $player2Ratings."
//           "\nPlayer 3 - Kills: $player3Kills, Assists: $player3Assists, Damage: $player3Damage, Survived Time: $player3Survived,"
//           // " Ratings: $player3Ratings."
//           "\nPlayer 4 - Kills: $player4Kills, Assists: $player4Assists, Damage: $player4Damage, Survived Time: $player4Survived,"
//           // " Ratings: $player4Ratings."
//           "\nTeam Stats - Health Restored: $teamHealthRestore, Rescues: $teamRescues, Recalls: $teamRecalls."
//           "\nCan you provide actionable feedback on how we can improve as a squad, including coordination, positioning, and combat strategy?";
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
//       // Optionally show success message
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
// }

// Updated SquadGameStatsController
class SquadGameStatsController extends GetxController {
  final player1NameController = TextEditingController();
  final player1KillsController = TextEditingController();
  final player1AssistsController = TextEditingController();
  final player1DamageController = TextEditingController();
  final player1SurvivedController = TextEditingController();


  final player2NameController = TextEditingController();
  final player2KillsController = TextEditingController();
  final player2AssistsController = TextEditingController();
  final player2DamageController = TextEditingController();
  final player2SurvivedController = TextEditingController();


  final player3NameController = TextEditingController();
  final player3KillsController = TextEditingController();
  final player3AssistsController = TextEditingController();
  final player3DamageController = TextEditingController();
  final player3SurvivedController = TextEditingController();


  final player4NameController = TextEditingController();
  final player4KillsController = TextEditingController();
  final player4AssistsController = TextEditingController();
  final player4DamageController = TextEditingController();
  final player4SurvivedController = TextEditingController();

  final player5NameController = TextEditingController();
  final player5KillsController = TextEditingController();
  final player5AssistsController = TextEditingController();
  final player5DamageController = TextEditingController();
  final player5SurvivedController = TextEditingController();

  final player6NameController = TextEditingController();
  final player6KillsController = TextEditingController();
  final player6AssistsController = TextEditingController();
  final player6DamageController = TextEditingController();
  final player6SurvivedController = TextEditingController();

  final teamHealthRestoreController = TextEditingController();
  final teamRescuesController = TextEditingController();
  // final teamChickenDinnerController = TextEditingController();
  final RxBool isTrue = true.obs;
  // ... [Keep your existing controller properties] ...

  final RxList<Map<String, dynamic>> statsList = <Map<String, dynamic>>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _loadStatsFromStorage();
  }

  updateChickenDinner(bool value){
    isTrue.value = value;
  }

  Future<void> _loadStatsFromStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final String? storedData = _prefs.getString('squad_game_stats');
    if (storedData != null) {
      statsList.value = List<Map<String, dynamic>>.from(json.decode(storedData));
    }
  }

  Future<void> _saveStatsToStorage() async {
    await _prefs.setString('squad_game_stats', json.encode(statsList));
  }

  void addStats() {
    final Map<String, dynamic> stats = {
      'player1': {
        'name': player1NameController.text,
        'kills': player1KillsController.text,
        'assists': player1AssistsController.text,
        'damage': player1DamageController.text,
        'survived': player1SurvivedController.text,
      },
      'player2': {
        'name': player2NameController.text,
        'kills': player2KillsController.text,
        'assists': player2AssistsController.text,
        'damage': player2DamageController.text,
        'survived': player2SurvivedController.text,
      },
      'player3': {
        'name': player3NameController.text,
        'kills': player3KillsController.text,
        'assists': player3AssistsController.text,
        'damage': player3DamageController.text,
        'survived': player3SurvivedController.text,
      },
      'player4': {
        'name': player4NameController.text,
        'kills': player4KillsController.text,
        'assists': player4AssistsController.text,
        'damage': player4DamageController.text,
        'survived': player4SurvivedController.text,
      },
      'player5': {
        'name': player5NameController.text,
        'kills': player5KillsController.text,
        'assists': player5AssistsController.text,
        'damage': player5DamageController.text,
        'survived': player5SurvivedController.text,
      },
      'player6': {
        'name': player6NameController.text,
        'kills': player6KillsController.text,
        'assists': player6AssistsController.text,
        'damage': player6DamageController.text,
        'survived': player6SurvivedController.text,
      },
      'team': {
        'healthRestore': teamHealthRestoreController.text,
        'rescues': teamRescuesController.text,
        'chickenDinner': isTrue.value,
      }
    };
    statsList.add(stats);
    _saveStatsToStorage();
    Get.snackbar(
      "Data Added",
      'The data has been added to database',
      snackPosition: SnackPosition.TOP,
      // backgroundColor: Colors.redAccent,
      colorText: Colors.black,
    );
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

    player2NameController.clear();
    player2KillsController.clear();
    player2AssistsController.clear();
    player2DamageController.clear();
    player2SurvivedController.clear();

    player3NameController.clear();
    player3KillsController.clear();
    player3AssistsController.clear();
    player3DamageController.clear();
    player3SurvivedController.clear();

    player4NameController.clear();
    player4KillsController.clear();
    player4AssistsController.clear();
    player4DamageController.clear();
    player4SurvivedController.clear();

    player5NameController.clear();
    player5KillsController.clear();
    player5AssistsController.clear();
    player5DamageController.clear();
    player5SurvivedController.clear();

    player6NameController.clear();
    player6KillsController.clear();
    player6AssistsController.clear();
    player6DamageController.clear();
    player6SurvivedController.clear();

    teamHealthRestoreController.clear();
    teamRescuesController.clear();
    // teamChickenDinnerController.clear();
    isTrue.value = false;
  }

  void analyzeData() async {
    print('object');

    final List<Map<String, dynamic>> dataToAnalyze = statsList.take(10).toList();

    String query = "I have played several squad games. Here are our stats:\n";
    for (var i = 0; i < dataToAnalyze.length; i++) {
      final game = dataToAnalyze[i];
      print(game['player5']['kills']);
      query += """
      Game ${i + 1}:
      Player 1 (name: ${game['player1']['name']}) - Kills: ${game['player1']['kills']}, Assists: ${game['player1']['assists']}, Damage: ${game['player1']['damage']}, Survived: ${game['player1']['survived']}
      Player 2 (name: ${game['player2']['name']}) - Kills: ${game['player2']['kills']}, Assists: ${game['player2']['assists']}, Damage: ${game['player2']['damage']}, Survived: ${game['player2']['survived']}
      Player 3 (name: ${game['player3']['name']}) - Kills: ${game['player3']['kills']}, Assists: ${game['player3']['assists']}, Damage: ${game['player3']['damage']}, Survived: ${game['player3']['survived']}
      Player 4 (name: ${game['player4']['name']}) - Kills: ${game['player4']['kills']}, Assists: ${game['player4']['assists']}, Damage: ${game['player4']['damage']}, Survived: ${game['player4']['survived']}
      ${game['player5']['kills'] !='' ? "Player 5 (name: ${game['player5']['name']}) - Kills: ${game['player5']['kills']}, Assists: ${game['player5']['assists']}, Damage: ${game['player5']['damage']}, Survived: ${game['player5']['survived']}" : ''}
      ${game['player6']['kills'] !='' ? "Player 6 (name: ${game['player6']['name']}) - Kills: ${game['player6']['kills']}, Assists: ${game['player6']['assists']}, Damage: ${game['player6']['damage']}, Survived: ${game['player6']['survived']}" : ''}

      Team Stats - Health Restored: ${game['team']['healthRestore']}, Rescues: ${game['team']['rescues']}, Chicken Dinner: ${game['team']['chickenDinner']}
   """;
    }
    query += """
    Based on these stats:
    - Provide actionable feedback to improve our squad's gameplay, positioning, and combat strategy.
    - Evaluate individual player contributions to the team across all games, focusing on the player's name rather than their in-game position (e.g., Player 1 in Game 1 might be Player 3 in Game 2).
    - Highlight specific strengths and weaknesses for each player in bullet points, ensuring clear spacing and readability.
    - Account for mixed player roles across different games and consolidate their performance under their respective names.
    - Ensure the feedback includes suggestions on how players can synergize better as a team, leveraging each player's strengths effectively.
    """;
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
}