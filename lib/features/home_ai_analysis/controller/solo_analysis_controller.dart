import 'package:esports/features/home_ai_analysis/services/gpt_services.dart';
import 'package:esports/features/home_ai_analysis/view/analysis_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

// class GameStatsController extends GetxController {
//   final killsController = TextEditingController();
//   final assistsController = TextEditingController();
//   final damageController = TextEditingController();
//   final survivedController = TextEditingController();
//   final healthRestoreController = TextEditingController();
//   final rescuesController = TextEditingController();
//   final recallsController = TextEditingController();
//   final ratingsController = TextEditingController();
//
//   late String query;
//
//   void submitForm() async {
//     try {
//       // Parse inputs
//       double kills = double.tryParse(killsController.text) ?? (throw Exception("Invalid Kills value"));
//       double assists = double.tryParse(assistsController.text) ?? (throw Exception("Invalid Assists value"));
//       double damage = double.tryParse(damageController.text) ?? (throw Exception("Invalid Damage value"));
//       double survived = double.tryParse(survivedController.text) ?? (throw Exception("Invalid Survived Time value"));
//       double healthRestore = double.tryParse(healthRestoreController.text) ?? (throw Exception("Invalid Health Restored value"));
//       double rescues = double.tryParse(rescuesController.text) ?? (throw Exception("Invalid Rescues value"));
//       double recalls = double.tryParse(recallsController.text) ?? (throw Exception("Invalid Recalls value"));
//       double ratings = double.tryParse(ratingsController.text) ?? (throw Exception("Invalid Ratings value"));
//
//       query = """
//       I recently played a Battle Royale solo game, and I want to improve my performance. Here are my stats from the game:
//       Kills: $kills
//       Assists: $assists
//       Damage: $damage
//       Survived Time: $survived
//       Health Restored: $healthRestore
//       Rescues: $rescues
//       Recalls: $recalls
//       Ratings: $ratings
//       Based on these stats, can you provide specific feedback or actionable tips on how I can improve my gameplay?
//       Suggestions on positioning, team coordination, aiming, or any other aspects would be appreciated.
//       """;
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
//     } catch (e) {
//       // Handle errors
//       Get.back(); // Close loading dialog if open
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//
//   @override
//   void onClose() {
//     killsController.dispose();
//     assistsController.dispose();
//     damageController.dispose();
//     survivedController.dispose();
//     healthRestoreController.dispose();
//     rescuesController.dispose();
//     recallsController.dispose();
//     ratingsController.dispose();
//     super.onClose();
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameStatsController extends GetxController {
  final nameController = TextEditingController();

  final killsController = TextEditingController();
  // final assistsController = TextEditingController();
  final damageController = TextEditingController();
  final survivedController = TextEditingController();
  final healthRestoreController = TextEditingController();
  // final rescuesController = TextEditingController();
  // final recallsController = TextEditingController();
  final ratingsController = TextEditingController();

  final RxList<Map<String, dynamic>> statsList = <Map<String, dynamic>>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _loadStatsFromStorage();
  }

  Future<void> _loadStatsFromStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final String? storedData = _prefs.getString('game_stats');
    if (storedData != null) {
      statsList.value = List<Map<String, dynamic>>.from(json.decode(storedData));
    }
  }

  Future<void> _saveStatsToStorage() async {
    await _prefs.setString('game_stats', json.encode(statsList));
  }

  void addStats() {
    final Map<String, dynamic> stats = {
      'kills': killsController.text,
      // 'assists': assistsController.text,
      'damage': damageController.text,
      'survived': survivedController.text,
      'healthRestore': healthRestoreController.text,
      // 'rescues': rescuesController.text,
      // 'recalls': recallsController.text,
      'ratings': ratingsController.text,
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
    killsController.clear();
    // assistsController.clear();
    damageController.clear();
    survivedController.clear();
    healthRestoreController.clear();
    // rescuesController.clear();
    // recallsController.clear();
    ratingsController.clear();
  }

  void analyzeData() async {
    final List<Map<String, dynamic>> dataToAnalyze = statsList.take(10).toList();

    // Construct the query for GPT
    String query = "I recently playeded a few Battle Royale solo games. Here's my stats:\n";
    for (var i = 0; i < dataToAnalyze.length; i++) {
      final entry = dataToAnalyze[i];
      query += """
      Game ${i + 1}:
      Kills: ${entry['kills']}
      Damage: ${entry['damage']}
      Survived Time: ${entry['survived']}
      Health Restored: ${entry['healthRestore']}
        Ratings: ${entry['ratings']}
      """;
    }
    query += "Based on these stats, provide actionable feedback for improving gameplay and  what I lack.";

    // Call GPT Service
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      String response = await GptServices().sendMsg(query);
      Get.back(); // Close the loading dialog
      Get.to(() => ResponseScreen(response: response));
    } catch (e) {
      Get.back(); // Close the loading dialog if open
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
