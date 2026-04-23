import 'package:flutter/material.dart';

class ActivityLogModel {
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData icon;
  final Color iconColor;
  final String? aiInsight; // Optional: Only for visits

  ActivityLogModel({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
    this.aiInsight,
  });
}
