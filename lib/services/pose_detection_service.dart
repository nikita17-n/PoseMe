import 'dart:io';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart'
    hide PoseLandmark, PoseLandmarkType;

import '../models/pose_landmark.dart';

/// Result of pose detection on an image.
class PoseDetectionResult {
  final List<PoseLandmark> landmarks;
  final int imageWidth;
  final int imageHeight;
  final bool hasPerson;

  const PoseDetectionResult({
    required this.landmarks,
    required this.imageWidth,
    required this.imageHeight,
    required this.hasPerson,
  });
}

/// Service that wraps Google ML Kit pose detection.
class PoseDetectionService {
  PoseDetector? _poseDetector;

  /// Lazy-initialize the pose detector.
  PoseDetector _getDetector() {
    return _poseDetector ??= PoseDetector(
      options: PoseDetectorOptions(
        mode: PoseDetectionMode.single,
        model: PoseDetectionModel.base,
      ),
    );
  }

  /// Detect pose landmarks from an image file.
  ///
  /// Returns null if no person is detected.
  /// Throws on detection failure.
  Future<PoseDetectionResult?> detectPose(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final detector = _getDetector();

    final poses = await detector.processImage(inputImage);

    if (poses.isEmpty) {
      return null;
    }

    // Use the first detected pose
    final pose = poses.first;

    // Get image dimensions for normalization
    final imageWidth = inputImage.metadata?.size.width ?? 0;
    final imageHeight = inputImage.metadata?.size.height ?? 0;

    final landmarks = <PoseLandmark>[];

    for (final entry in pose.landmarks.entries) {
      final mlLandmark = entry.value;
      landmarks.add(
        PoseLandmark(
          type: _convertLandmarkType(entry.key),
          x: mlLandmark.x,
          y: mlLandmark.y,
          z: mlLandmark.z,
          likelihood: mlLandmark.likelihood,
        ),
      );
    }

    return PoseDetectionResult(
      landmarks: landmarks,
      imageWidth: imageWidth.toInt(),
      imageHeight: imageHeight.toInt(),
      hasPerson: true,
    );
  }

  /// Convert ML Kit's PoseLandmarkType to our own enum.
  PoseLandmarkType _convertLandmarkType(dynamic mlType) {
    // ML Kit uses the same enum values, just convert by index/name
    final name = mlType.toString().split('.').last;
    return PoseLandmarkType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => PoseLandmarkType.nose,
    );
  }

  /// Release resources.
  void dispose() {
    _poseDetector?.close();
    _poseDetector = null;
  }
}
