import 'package:esports/features/news/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Details',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                article.title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              // Date
              Text(
                DateFormat('MMM dd, yyyy').format(article.createdAt),
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              // Description
              Text(
                article.description,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              // SizedBox(height: 20),
              // // Optional: Add more details if available
              // Text(
              //   'Additional Content (if any)',
              //   style: GoogleFonts.roboto(
              //     fontSize: 16,
              //     fontStyle: FontStyle.italic,
              //     color: Colors.black54,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
