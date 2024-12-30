import 'package:esports/core/constants/MySize.dart';
import 'package:esports/features/auth/controller/user_controller.dart';
import 'package:esports/features/home_ai_analysis/widget/custom_drawer.dart';

import 'package:esports/features/news/controller/news_controller.dart';
import 'package:esports/features/news/model/news_model.dart';
import 'package:esports/features/news/view/add_news.dart';
import 'package:esports/features/news/view/news_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class NewsScreen extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _userController.onInit();

    return Scaffold(
      drawer: CustomDrawer(),

      appBar: AppBar(
        title: Text(
          'Latest News',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          _userController.currentUser?.email != 'admin@gmail.com' ?
          IconButton(onPressed: (){  Get.to(() =>AddNewsScreen());}, icon: Icon(Icons.add)):
              Container()
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (_newsController.isLoading.value) {
          return Center(
            child: SpinKitWave(
              color: Colors.blue,
              size: 50.0,
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: MySize.screenHeight* 0.8,
              child: RefreshIndicator(
                onRefresh: _newsController.fetchNews,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: _newsController.news.length,
                  itemBuilder: (context, index) {
                    final NewsArticle article;

                    article = _newsController.news[index];
                    return NewsArticleCard(article: article);
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class NewsArticleCard extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsDetailScreen(article: article));

        // Optional: Navigate to article details
        // Get.to(() => NewsDetailScreen(article: article));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            // ClipRRect(
            //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            //   child: CachedNetworkImage(
            //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/traffic-pro-b76a1.appspot.com/o/images%2F2024-05-09%2009%3A41%3A43.874344?alt=media&token=c1f9b06e-6b53-478d-881e-297d2f2c6a34',   //article.imageUrl,
            //     height: 200,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //     placeholder: (context, url) => Center(
            //       child: SpinKitPulse(color: Colors.blue),
            //     ),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   ),
            // ),

            // Content
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.description,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(article.createdAt),
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.blue,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}