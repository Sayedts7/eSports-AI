import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/news_controller.dart';

class AddNewsScreen extends StatelessWidget {
  final AddNewsController _controller = Get.put(AddNewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add News Article',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Picker
            // Obx(() {
            //   return GestureDetector(
            //     onTap: _controller.pickImage,
            //     child: Container(
            //       height: 200,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[200],
            //         borderRadius: BorderRadius.circular(15),
            //         image: _controller.imagePath.value.isNotEmpty
            //             ? DecorationImage(
            //           image: FileImage(File(_controller.imagePath.value)),
            //           fit: BoxFit.cover,
            //         )
            //             : null,
            //       ),
            //       child: _controller.imagePath.value.isEmpty
            //           ? Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.cloud_upload,
            //             size: 50,
            //             color: Colors.grey[600],
            //           ),
            //           SizedBox(height: 10),
            //           Text(
            //             'Upload Image',
            //             style: GoogleFonts.poppins(
            //               color: Colors.grey[600],
            //             ),
            //           )
            //         ],
            //       )
            //           : null,
            //     ),
            //   );
            // }),

            SizedBox(height: 16),

            // Title TextField
            TextField(
              controller: _controller.titleController,
              decoration: InputDecoration(
                labelText: 'News Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.title),
              ),
              style: GoogleFonts.poppins(),
            ),

            SizedBox(height: 16),

            // Description TextField
            TextField(
              controller: _controller.descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'News Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description),
              ),
              style: GoogleFonts.poppins(),
            ),

            SizedBox(height: 24),

            // Submit Button
            Obx(() {
              return ElevatedButton(
                onPressed: _controller.isLoading.value
                    ? null
                    : _controller.uploadNews,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Add News Article',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}