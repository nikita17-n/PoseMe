import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'pose_match_result_screen.dart';

/// Live camera screen — UI placeholder.
///
/// The real camera preview is not wired up yet (no camera plugin is
/// included in this project). This screen presents the full camera UX —
/// ghost overlay, match score, instruction card and capture button — so
/// the flow can be designed and tested. The capture action currently
/// navigates to the result screen as a UI placeholder only.
class LiveCameraScreen extends StatefulWidget {
  const LiveCameraScreen({super.key});

  @override
  State<LiveCameraScreen> createState() => _LiveCameraScreenState();
}

class _LiveCameraScreenState extends State<LiveCameraScreen> {
  bool _flashOn = false;

  void _capture() {
    // UI placeholder — real capture is not implemented yet.
    Navigator.of(context)
        .push(PosePageRoute(builder: (_) => const PoseMatchResultScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPlum,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera preview placeholder.
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4A3542), Color(0xFF2A1B24)],
                  ),
                ),
                child: const Center(
                  child: PoseIcon(
                    PoseIconType.camera,
                    size: 54,
                    color: AppColors.blushPink,
                  ),
                ),
              ),
            ),

            // Ghost / skeleton overlay placeholder.
            const Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: PoseFigure(
                    height: 320,
                    color: AppColors.blushPink,
                    sparkleColor: AppColors.softPeach,
                  ),
                ),
              ),
            ),

            // Top controls.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  PoseIconButton(
                    icon: PoseIconType.back,
                    color: AppColors.softIvory,
                    background: Colors.black26,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const Spacer(),
                  PoseIconButton(
                    icon: PoseIconType.flash,
                    color: _flashOn ? AppColors.softRose : AppColors.softIvory,
                    background: Colors.black26,
                    onPressed: () => setState(() => _flashOn = !_flashOn),
                  ),
                  const SizedBox(width: 10),
                  PoseIconButton(
                    icon: PoseIconType.flip,
                    color: AppColors.softIvory,
                    background: Colors.black26,
                    onPressed: () {
                      // UI placeholder — camera switching not implemented.
                    },
                  ),
                ],
              ),
            ),

            // Bottom controls.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 26),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Match score pill.
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusChip,
                        ),
                        border: Border.all(
                          color: AppColors.blushPink.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Sparkle(size: 14),
                          SizedBox(width: 8),
                          Text(
                            'Match score appears here',
                            style: TextStyle(
                              color: AppColors.softIvory,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Instruction card.
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softIvory,
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusCard,
                        ),
                      ),
                      child: Row(
                        children: [
                          const PoseIcon(
                            PoseIconType.poseMatch,
                            size: 22,
                            color: AppColors.dustyRose,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Follow the ghost overlay to match the pose',
                              style: AppTextStyles.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Capture row.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_CaptureButton(onTap: _capture)],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Hold your pose',
                      style: TextStyle(
                        color: AppColors.blushPink,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaptureButton extends StatefulWidget {
  final VoidCallback onTap;

  const _CaptureButton({required this.onTap});

  @override
  State<_CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<_CaptureButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.softIvory, width: 3.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: AppColors.softRose,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: PoseIcon(
                  PoseIconType.capture,
                  size: 26,
                  color: AppColors.deepPlum,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
