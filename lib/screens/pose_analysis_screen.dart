import 'dart:io';

import 'package:flutter/material.dart';

import '../models/pose_landmark.dart';
import '../services/pose_detection_service.dart';
import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import '../widgets/pose_skeleton_painter.dart';
import 'live_camera_screen.dart';

class PoseAnalysisScreen extends StatefulWidget {
  final File imageFile;

  const PoseAnalysisScreen({super.key, required this.imageFile});

  @override
  State<PoseAnalysisScreen> createState() => _PoseAnalysisScreenState();
}

class _PoseAnalysisScreenState extends State<PoseAnalysisScreen> {
  final PoseDetectionService _poseService = PoseDetectionService();

  bool _isAnalyzing = true;
  bool _hasError = false;
  String _errorMessage = '';
  PoseDetectionResult? _result;

  @override
  void initState() {
    super.initState();
    _analyzePose();
  }

  @override
  void dispose() {
    _poseService.dispose();
    super.dispose();
  }

  Future<void> _analyzePose() async {
    try {
      final result = await _poseService.detectPose(widget.imageFile);

      if (!mounted) return;

      if (result == null) {
        setState(() {
          _isAnalyzing = false;
          _hasError = true;
          _errorMessage =
              'No person detected. Please choose an image containing a person.';
        });
        return;
      }

      setState(() {
        _isAnalyzing = false;
        _result = result;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isAnalyzing = false;
        _hasError = true;
        _errorMessage =
            'Pose could not be detected clearly. Try another image.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Pose Analysis'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isAnalyzing) {
      return _AnalyzingView(imageFile: widget.imageFile);
    }

    if (_hasError) {
      return _ErrorView(
        message: _errorMessage,
        onBack: () => Navigator.of(context).maybePop(),
      );
    }

    return _ResultView(
      imageFile: widget.imageFile,
      result: _result!,
      onTryLive: () {
        Navigator.of(context)
            .push(PosePageRoute(builder: (_) => const LiveCameraScreen()));
      },
    );
  }
}

// ============================ analyzing ============================

class _AnalyzingView extends StatelessWidget {
  final File imageFile;

  const _AnalyzingView({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text('Reading your pose...', style: AppTextStyles.heading),
          const SizedBox(height: 10),
          const Text('Finding your pose landmarks', style: AppTextStyles.body),
          const SizedBox(height: 28),
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(imageFile, fit: BoxFit.cover),
                    // Soft rose tint so the photo feels part of the UI.
                    Container(
                      color: AppColors.softRose.withValues(alpha: 0.10),
                    ),
                    const _ScanOverlay(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Sparkle(size: 16),
              SizedBox(width: 10),
              Text('AI is studying the photo', style: AppTextStyles.caption),
              SizedBox(width: 10),
              Sparkle(size: 16),
            ],
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }
}

/// Animated scanning line + corner frame shown while analyzing.
class _ScanOverlay extends StatefulWidget {
  const _ScanOverlay();

  @override
  State<_ScanOverlay> createState() => _ScanOverlayState();
}

class _ScanOverlayState extends State<_ScanOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ScanFramePainter(progress: _controller.value),
          child: child,
        );
      },
      child: const SizedBox.expand(),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  final double progress;

  _ScanFramePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final frame = Paint()
      ..color = AppColors.softRose
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const corner = 26.0;
    const inset = 14.0;
    final w = size.width;
    final h = size.height;

    final path = Path()
      // top-left
      ..moveTo(inset, inset + corner)
      ..lineTo(inset, inset)
      ..lineTo(inset + corner, inset)
      // top-right
      ..moveTo(w - inset - corner, inset)
      ..lineTo(w - inset, inset)
      ..lineTo(w - inset, inset + corner)
      // bottom-right
      ..lineTo(w - inset, h - inset - corner)
      ..lineTo(w - inset, h - inset)
      ..lineTo(w - inset - corner, h - inset)
      // bottom-left
      ..lineTo(inset + corner, h - inset)
      ..lineTo(inset, h - inset)
      ..lineTo(inset, h - inset - corner);
    canvas.drawPath(path, frame);

    // Scanning line sweeping vertically.
    final y = inset + (h - inset * 2) * progress;
    final line = Paint()
      ..color = AppColors.dustyRose.withValues(alpha: 0.85)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(inset + corner, y),
      Offset(w - inset - corner, y),
      line,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanFramePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ============================== error ==============================

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onBack;

  const _ErrorView({required this.message, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(
              color: AppColors.softPeach,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: PoseIcon(
                PoseIconType.body,
                size: 40,
                color: AppColors.dustyRose,
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(message, textAlign: TextAlign.center, style: AppTextStyles.body),
          const SizedBox(height: 30),
          PosePrimaryButton(
            label: 'Go Back',
            icon: PoseIconType.back,
            onPressed: onBack,
          ),
        ],
      ),
    );
  }
}

// ============================== result ==============================

class _ResultView extends StatelessWidget {
  final File imageFile;
  final PoseDetectionResult result;
  final VoidCallback onTryLive;

  const _ResultView({
    required this.imageFile,
    required this.result,
    required this.onTryLive,
  });

  @override
  Widget build(BuildContext context) {
    final confidence = _averageConfidence(result.landmarks);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.screenPadding,
        4,
        AppDimens.screenPadding,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image with skeleton overlay.
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusImage),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.hairline),
                borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 22,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SizedBox(
                height: 340,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(imageFile, fit: BoxFit.cover),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: PoseSkeletonPainter(
                          landmarks: result.landmarks,
                          imageWidth: result.imageWidth,
                          imageHeight: result.imageHeight,
                          renderedWidth:
                              MediaQuery.of(context).size.width -
                              AppDimens.screenPadding * 2,
                          renderedHeight: 340,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Detection summary card.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.softIvory,
              borderRadius: BorderRadius.circular(AppDimens.radiusCard),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Row(
              children: [
                const PoseIcon(
                  PoseIconType.sparkle,
                  size: 22,
                  color: AppColors.dustyRose,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pose detected ✨',
                        style: AppTextStyles.bodyStrong,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${result.landmarks.length} landmarks · '
                        '${(confidence * 100).toStringAsFixed(0)}% confidence',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softSage.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(AppDimens.radiusChip),
                  ),
                  child: Text(
                    'Good',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.deepPlum,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          PosePrimaryButton(
            label: 'Try It Live',
            icon: PoseIconType.camera,
            onPressed: onTryLive,
          ),

          const SizedBox(height: 26),

          Text('DETECTED LANDMARKS', style: AppTextStyles.label),
          const SizedBox(height: 12),

          // Landmark list.
          ...result.landmarks.map((lm) => _LandmarkTile(landmark: lm)),
        ],
      ),
    );
  }

  double _averageConfidence(List<PoseLandmark> landmarks) {
    if (landmarks.isEmpty) return 0;
    final sum = landmarks.fold<double>(0, (acc, lm) => acc + lm.likelihood);
    return (sum / landmarks.length).clamp(0.0, 1.0);
  }
}

class _LandmarkTile extends StatelessWidget {
  final PoseLandmark landmark;

  const _LandmarkTile({required this.landmark});

  @override
  Widget build(BuildContext context) {
    final confidence = landmark.likelihood;
    final Color indicatorColor = confidence > 0.7
        ? AppColors.softSage
        : confidence > 0.4
        ? AppColors.softRose
        : AppColors.mauve;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.softIvory,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              _formatLandmarkName(landmark.type.name),
              style: AppTextStyles.bodyStrong.copyWith(fontSize: 13.5),
            ),
          ),
          Expanded(
            child: Text(
              'x: ${landmark.x.toStringAsFixed(1)}',
              style: AppTextStyles.caption.copyWith(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              'y: ${landmark.y.toStringAsFixed(1)}',
              style: AppTextStyles.caption.copyWith(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              'conf: ${(confidence * 100).toStringAsFixed(0)}%',
              textAlign: TextAlign.right,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
                color: indicatorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLandmarkName(String name) {
    final result = name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result[0].toUpperCase() + result.substring(1);
  }
}
