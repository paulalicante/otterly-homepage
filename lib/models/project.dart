import 'package:flutter/material.dart';

class Project {
  final String title;
  final String tagline;
  final String description;
  final List<String> highlights;
  final List<String> techStack;
  final IconData icon;
  final bool isFeatured;
  final bool isLive;
  final String? liveUrl;
  final String? githubUrl;
  final String? logoAsset;

  const Project({
    required this.title,
    required this.tagline,
    this.description = '',
    this.highlights = const [],
    this.techStack = const [],
    this.icon = Icons.code,
    this.isFeatured = false,
    this.isLive = false,
    this.liveUrl,
    this.githubUrl,
    this.logoAsset,
  });
}
