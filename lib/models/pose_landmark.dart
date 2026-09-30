import 'dart:ui';

/// A single body landmark detected by the pose detector.
class PoseLandmark {
  final PoseLandmarkType type;
  final double x;
  final double y;
  final double? z;
  final double likelihood;

  const PoseLandmark({
    required this.type,
    required this.x,
    required this.y,
    this.z,
    required this.likelihood,
  });

  /// Normalized coordinates (0.0 to 1.0) relative to image dimensions.
  Offset normalized(int imageWidth, int imageHeight) {
    return Offset(x / imageWidth, y / imageHeight);
  }

  @override
  String toString() => '${type.name}: ($x, $y, likelihood: $likelihood)';
}

/// The 33 standard body landmark types.
enum PoseLandmarkType {
  nose,
  leftEyeInner,
  leftEye,
  leftEyeOuter,
  rightEyeInner,
  rightEye,
  rightEyeOuter,
  leftEar,
  rightEar,
  leftMouth,
  rightMouth,
  leftShoulder,
  rightShoulder,
  leftElbow,
  rightElbow,
  leftWrist,
  rightWrist,
  leftPinky,
  rightPinky,
  leftIndex,
  rightIndex,
  leftThumb,
  rightThumb,
  leftHip,
  rightHip,
  leftKnee,
  rightKnee,
  leftAnkle,
  rightAnkle,
  leftHeel,
  rightHeel,
  leftFootIndex,
  rightFootIndex,
}

/// Connections between landmarks for drawing a skeleton.
const List<(PoseLandmarkType, PoseLandmarkType)> poseConnections = [
  // Face
  (PoseLandmarkType.nose, PoseLandmarkType.leftEyeInner),
  (PoseLandmarkType.leftEyeInner, PoseLandmarkType.leftEye),
  (PoseLandmarkType.leftEye, PoseLandmarkType.leftEyeOuter),
  (PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner),
  (PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEye),
  (PoseLandmarkType.rightEye, PoseLandmarkType.rightEyeOuter),
  (PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEar),
  (PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar),
  (PoseLandmarkType.leftMouth, PoseLandmarkType.rightMouth),
  (PoseLandmarkType.nose, PoseLandmarkType.leftMouth),
  (PoseLandmarkType.nose, PoseLandmarkType.rightMouth),

  // Torso
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder),
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip),
  (PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip),
  (PoseLandmarkType.leftHip, PoseLandmarkType.rightHip),

  // Left arm
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow),
  (PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinky),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndex),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb),
  (PoseLandmarkType.leftPinky, PoseLandmarkType.leftIndex),

  // Right arm
  (PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow),
  (PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinky),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndex),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb),
  (PoseLandmarkType.rightPinky, PoseLandmarkType.rightIndex),

  // Left leg
  (PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee),
  (PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle),
  (PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel),
  (PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex),
  (PoseLandmarkType.leftHeel, PoseLandmarkType.leftFootIndex),

  // Right leg
  (PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee),
  (PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle),
  (PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel),
  (PoseLandmarkType.rightAnkle, PoseLandmarkType.rightFootIndex),
  (PoseLandmarkType.rightHeel, PoseLandmarkType.rightFootIndex),
];
