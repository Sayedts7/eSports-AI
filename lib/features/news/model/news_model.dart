import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String id;
  final String title;
  final String description;
  // final String imageUrl;
  final DateTime createdAt;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    // required this.imageUrl,
    required this.createdAt,
  });

  factory NewsArticle.fromFirestore(Map<String, dynamic> data, String documentId) {
    return NewsArticle(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      // imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      // 'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}