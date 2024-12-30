import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esports/features/news/model/news_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';


class NewsController extends GetxController {
  final RxList<NewsArticle> _news = <NewsArticle>[].obs;
  RxBool isLoading = false.obs;

  List<NewsArticle> get news => _news;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('news')
          .orderBy('createdAt', descending: true)
          .get();

      _news.value = snapshot.docs
          .map((doc) => NewsArticle.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class AddNewsController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxString imagePath = ''.obs;
  final RxBool isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  Future<void> uploadNews() async {
    // Validate inputs
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty
        // ||
        // imagePath.value.isEmpty
    ) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    try {
      isLoading.value = true;

      // Upload image to Firebase Storage
      // final file = File(imagePath.value);
      // final storageRef = FirebaseStorage.instance
      //     .ref()
      //     .child('news_images/${DateTime.now().millisecondsSinceEpoch}');
      //
      // final uploadTask = await storageRef.putFile(file);
      // final imageUrl = await uploadTask.ref.getDownloadURL();

      // Create news article in Firestore
      final newsArticle = NewsArticle(
        id: '', // Firestore will generate this
        title: titleController.text,
        description: descriptionController.text,
        // imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('news')
          .add(newsArticle.toMap());

      // Clear fields and image after successful upload
      titleController.clear();
      descriptionController.clear();
      imagePath.value = '';

      Get.snackbar('Success', 'News article added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload news: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}