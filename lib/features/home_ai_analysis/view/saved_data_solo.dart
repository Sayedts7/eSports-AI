import 'package:esports/core/constants/MySize.dart';
import 'package:esports/features/home_ai_analysis/controller/solo_analysis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedGameStatsScreen extends StatelessWidget {
  final GameStatsController controller = Get.find<GameStatsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solo Performance History"),
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
        child: Obx(
              () => controller.statsList.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assessment_outlined,
                  size: MySize.size64,
                  color: Colors.grey[400],
                ),
                 SizedBox(height: MySize.size16),
                Text(
                  "No Solo Stats Yet",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add your first game stats to get started",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding:  EdgeInsets.all(MySize.size16),
            itemCount: controller.statsList.length,
            itemBuilder: (context, index) {
              final stats = controller.statsList[index];
              return Card(
                margin:  EdgeInsets.only(bottom: MySize.size16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding:  EdgeInsets.symmetric(horizontal: MySize.size16, vertical: MySize.size8),
                    title: Row(
                      children: [
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: MySize.size12, vertical: MySize.size6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Game ${index + 1}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                         SizedBox(width: MySize.size12),
                        Text(
                          "Solo Performance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(MySize.size16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPlayerStatsCard("Player", stats, context),
                            // _buildPlayerStatsCard("Player 2", stats['player2'], context),
                            // _buildTeamStatsCard(stats['team'], context),
                             SizedBox(height: MySize.size16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                                  label: Text(
                                    "Delete Entry",
                                    style: TextStyle(color: Colors.red[400]),
                                  ),
                                  onPressed: () {
                                    _showDeleteConfirmation(context, index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Obx(
            () => controller.statsList.length >= 5
            ? FloatingActionButton.extended(
          onPressed: controller.analyzeData,
          icon: const Icon(Icons.analytics),
          label: const Text("Analyze Performance"),
          elevation: 4,
        )
            : Container(),
      ),
    );
  }

  Widget _buildPlayerStatsCard(String title, Map<String, dynamic> stats, BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: MySize.size12),
      padding:  EdgeInsets.all(MySize.size12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
           SizedBox(height: MySize.size8),
          Row(
            children: [
              _buildStatItem(Icons.adjust, "Kills", stats['kills']),
              // _buildStatItem(Icons.handshake, "Assists", stats['assists']),
              _buildStatItem(Icons.flash_on, "Damage", stats['damage']),

            ],
          ),
           SizedBox(height: MySize.size8),
          Row(
            children: [
              _buildStatItem(Icons.timer, "Survived", stats['survived']),
              _buildStatItem(Icons.star, "Rating", stats['ratings']),

            ],
          ),
          // Row(
          //   children: [
          //     _buildStatItem(Icons.flash_on, "Damage", stats['damage']),
          //     _buildStatItem(Icons.timer, "Survived", stats['survived']),
          //   ],
          // ),
           SizedBox(height: MySize.size8),
          Row(
            children: [
              _buildStatItem(Icons.healing, "Health Restore", stats['healthRestore']),
      ],
          ),
          // const SizedBox(height: 8),
          //
          // Row(
          //   children: [
          //
          //     _buildStatItem(Icons.replay, "Recalls", stats['recalls']),
          //   ],
          // ),
        ],
      ),
    );
  }



  Widget _buildStatItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: MySize.size16, color: Colors.grey[600]),
           SizedBox(width: MySize.size4),
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Game Stats"),
          content: const Text("Are you sure you want to delete this game's statistics?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteStats(index);
                Navigator.pop(context);
                Get.snackbar(
                  "Deleted",
                  "Game statistics have been removed",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}