import 'package:esports/core/constants/MySize.dart';
import 'package:esports/features/home_ai_analysis/controller/squad_analysis_controller.dart';
import 'package:esports/features/home_ai_analysis/view/players_data_summed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class SavedSquadStatsScreen extends StatelessWidget {
  final SquadGameStatsController controller = Get.find<SquadGameStatsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:   Text("Squad Performance History"),
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
                  "No Squad Stats Yet",
                  style: TextStyle(
                    fontSize: MySize.size20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                  SizedBox(height: MySize.size8),
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
            padding:   EdgeInsets.all(MySize.size16),
            itemCount: controller.statsList.length,
            itemBuilder: (context, index) {
              final stats = controller.statsList[index];
              // print(stats);
              // print(stats['player5']);
              print(stats['player5']?['kills'] == null);

              // if (stats.containsKey('player5') && stats['player5'] != null) {
                print(stats['player6']['name']);
              //   print('stats');
              //
              // } else {
              //   print("player5 does not exist or is null");
              // }
              return Card(
                margin:   EdgeInsets.only(bottom: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding:   EdgeInsets.symmetric(horizontal: MySize.size16, vertical: MySize.size8),
                    title: Row(
                      children: [
                        Container(
                          padding:   EdgeInsets.symmetric(horizontal: MySize.size12, vertical: MySize.size6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(MySize.size20),
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
                          "Squad Performance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding:   EdgeInsets.all(MySize.size16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPlayerStatsCard(stats['player1']['name'], stats['player1'], context),
                            _buildPlayerStatsCard(stats['player2']['name'], stats['player2'], context),
                            _buildPlayerStatsCard(stats['player3']['name'], stats['player3'], context),
                            _buildPlayerStatsCard(stats['player4']['name'], stats['player4'], context),
                            (stats['player5']?['kills']) != ''?
                            _buildPlayerStatsCard(stats['player5']['name'], stats['player5'], context):Container(),
                            (stats['player6']?['kills']  ) != ''?
                            _buildPlayerStatsCard(stats['player6']['name'], stats['player6'], context):Container(),

                            _buildTeamStatsCard(stats['team'], context),
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
            () => controller.statsList.length >= 1
            ? FloatingActionButton.extended(
          onPressed: (){
            Get.to(()=> SummarizedSquadStatsScreen());
          },//controller.analyzeData,
          icon:   Icon(Icons.analytics),
          label:   Text("Summarize Performance"),
          elevation: 4,
        )
            : Container(),
      ),
    );
  }

  Widget _buildPlayerStatsCard(String title, Map<String, dynamic> stats, BuildContext context) {
    return Container(
      margin:   EdgeInsets.only(bottom: MySize.size12),
      padding:   EdgeInsets.all(MySize.size12),
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
              _buildStatItem(Icons.add, "Kills", stats['kills']),
              _buildStatItem(Icons.handshake, "Assists", stats['assists']),
            ],
          ),
            SizedBox(height: MySize.size8),
          Row(
            children: [
              _buildStatItem(Icons.flash_on, "Damage", stats['damage']),
              _buildStatItem(Icons.timer, "Survived", stats['survived']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamStatsCard(Map<String, dynamic> stats, BuildContext context) {
    return Container(
      padding:   EdgeInsets.all(MySize.size12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Stats",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MySize.size16,
              color: Theme.of(context).primaryColor,
            ),
          ),
            SizedBox(height: MySize.size8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(Icons.healing, "Health Restore", stats['healthRestore']),
              _buildStatItem(Icons.people, "Rescues", stats['rescues']),
            ],
          ),
          SizedBox(height: MySize.size8),

          Row(
            children: [
              _buildStatItem(Icons.emoji_events, "Chicken Dinner", stats['chickenDinner']? 'Yes': 'No'),

            ],
          ),
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
            style:   TextStyle(
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
          title:   Text("Delete Game Stats"),
          content:   Text("Are you sure you want to delete this game's statistics?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:   Text("Cancel"),
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
              child:   Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}