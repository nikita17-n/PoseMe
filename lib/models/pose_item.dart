import 'package:flutter/material.dart';

/// A pose item used across home, explore, and details screens.
class PoseItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final Color tint1;
  final Color tint2;

  const PoseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.tint1,
    required this.tint2,
  });
}
