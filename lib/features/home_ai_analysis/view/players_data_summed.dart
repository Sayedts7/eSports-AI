import 'package:esports/features/home_ai_analysis/controller/squad_analysis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummarizedSquadStatsScreen extends StatelessWidget {
  final SquadGameStatsController controller = Get.find<SquadGameStatsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
            () => controller.statsList.length >= 1
            ? FloatingActionButton.extended(
          onPressed:
         controller.analyzeData,
          icon:   Icon(Icons.analytics),
          label:   Text("Analyze Performance"),
          elevation: 4,
        )
            : Container(),
      ),
      appBar: AppBar(
        title: Text("Summarized Squad Stats"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Obx(() {
          if (controller.statsList.isEmpty) {
            return Center(
              child: Text(
                "No Squad Stats Yet",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            );
          }

          // Aggregating player data
          final Map<String, Map<String, int>> playerData = {};
          final Map<String, int> teamData = {
            'healthRestore': 0,
            'rescues': 0,
            'chickenDinner': 0,
          };

          for (var stats in controller.statsList) {
            for (int i = 1; i <= 6; i++) {
              final player = stats['player$i'];
              print(player['name']);
              if (player != null && player['name'] != null && player['name'] != '') {
                final playerName = player['name'];
                playerData[playerName] ??= {
                  'kills': 0,
                  'assists': 0,
                  'damage': 0,
                  'survived': 0,
                };

                playerData[playerName]!['kills'] =
                (playerData[playerName]!['kills']!  + int.parse((player['kills'] ?? 0).toString())) as int;

                playerData[playerName]!['assists'] =
                (playerData[playerName]!['assists']!  + int.parse((player['assists'] ?? 0))) as int;

                playerData[playerName]!['damage'] =
                (playerData[playerName]!['damage']!+ int.parse((player['damage'] ?? 0))) as int;

                playerData[playerName]!['survived'] =
                (playerData[playerName]!['survived']!  + int.parse((player['survived'] ?? 0))) as int;
              }
            }
            print("Player Data: $playerData"); // Debug statement


            final team = stats['team'];
            if (team != null) {
              teamData['healthRestore'] =
              ((teamData['healthRestore'] ?? 0).toInt() + int.parse((team['healthRestore']?? 0).toString())) as int;

              teamData['rescues'] =
              ((teamData['rescues'] ?? 0) + int.parse((team['rescues'] ?? 0).toString())) as int;

              teamData['chickenDinner'] =
              ((teamData['chickenDinner'] ?? 0) +
                  ((team['chickenDinner'] == true) ? 1 : 0)) as int;
            }
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                "Player Stats",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 16),
              ...playerData.entries.map((entry) => _buildPlayerSummaryCard(entry.key, entry.value, context)).toList(),
              SizedBox(height: 24),
              Text(
                "Team Stats",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 16),
              _buildTeamSummaryCard(teamData, context),
              SizedBox(height: 100),

            ],
          );
        }),
      ),
    );
  }

  Widget _buildPlayerSummaryCard(String playerName, Map<String, int> stats, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8),
            _buildStatRow("Kills", stats['kills']!),
            _buildStatRow("Assists", stats['assists']!),
            _buildStatRow("Damage", stats['damage']!),
            _buildStatRow("Survived", stats['survived']!),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamSummaryCard(Map<String, int> stats, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatRow("Health Restored", stats['healthRestore']!),
            _buildStatRow("Rescues", stats['rescues']!),
            _buildStatRow("Chicken Dinners", stats['chickenDinner']!),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
