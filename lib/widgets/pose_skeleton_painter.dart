import 'package:flutter/material.dart';

import '../models/pose_landmark.dart';
import '../theme/app_theme.dart';

/// Custom painter that draws a pose skeleton over an image.
class PoseSkeletonPainter extends CustomPainter {
  final List<PoseLandmark> landmarks;
  final int imageWidth;
  final int imageHeight;
  final double renderedWidth;
  final double renderedHeight;

  PoseSkeletonPainter({
    required this.landmarks,
    required this.imageWidth,
    required this.imageHeight,
    required this.renderedWidth,
    required this.renderedHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (landmarks.isEmpty || imageWidth == 0 || imageHeight == 0) return;

    final scaleX = renderedWidth / imageWidth;
    final scaleY = renderedHeight / imageHeight;

    // Build a lookup map for quick access
    final landmarkMap = <PoseLandmarkType, PoseLandmark>{};
    for (final lm in landmarks) {
      landmarkMap[lm.type] = lm;
    }

    final bonePaint = Paint()
      ..color = AppColors.dustyRose
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final jointPaint = Paint()
      ..color = AppColors.softRose
      ..style = PaintingStyle.fill;

    // Draw bones
    for (final (start, end) in poseConnections) {
      final startLm = landmarkMap[start];
      final endLm = landmarkMap[end];
      if (startLm == null || endLm == null) continue;

      // Skip low-confidence landmarks
      if (startLm.likelihood < 0.5 || endLm.likelihood < 0.5) continue;

      final startOffset = Offset(startLm.x * scaleX, startLm.y * scaleY);
      final endOffset = Offset(endLm.x * scaleX, endLm.y * scaleY);

      canvas.drawLine(startOffset, endOffset, bonePaint);
    }

    // Draw joints
    for (final lm in landmarks) {
      if (lm.likelihood < 0.5) continue;
      final offset = Offset(lm.x * scaleX, lm.y * scaleY);
      canvas.drawCircle(offset, 4.0, jointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PoseSkeletonPainter oldDelegate) {
    return oldDelegate.landmarks != landmarks ||
        oldDelegate.renderedWidth != renderedWidth ||
        oldDelegate.renderedHeight != renderedHeight;
  }
}
