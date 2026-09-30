import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pose_icons.dart';

/// The PoseMe logo.
///
/// A minimal, elegant human silhouette whose body forms a subtle "P",
/// with a tiny sparkle beside the raised hand. Rendered as a line-art
/// illustration so it stays crisp at any size — app bar, splash or icon.
class PoseLogo extends StatelessWidget {
  final double size;
  final Color color;
  final Color sparkleColor;
  final bool withSparkle;

  const PoseLogo({
    super.key,
    this.size = 72,
    this.color = AppColors.softRose,
    this.sparkleColor = AppColors.dustyRose,
    this.withSparkle = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PoseLogoPainter(
          color: color,
          sparkleColor: sparkleColor,
          withSparkle: withSparkle,
        ),
      ),
    );
  }
}

class _PoseLogoPainter extends CustomPainter {
  final Color color;
  final Color sparkleColor;
  final bool withSparkle;

  _PoseLogoPainter({
    required this.color,
    required this.sparkleColor,
    required this.withSparkle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 64; // design grid is 64x64

    void scale(void Function(Canvas) draw) {
      canvas.save();
      canvas.scale(s);
      draw(canvas);
      canvas.restore();
    }

    scale((canvas) {
      final body = Paint()
        ..color = color
        ..strokeWidth = 6.4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      // Head.
      canvas.drawCircle(const Offset(21, 12.5), 6.4, Paint()..color = color);

      // Body — the vertical stroke of the "P".
      canvas.drawLine(const Offset(21, 21), const Offset(21, 47), body);

      // Arm curving out to form the bowl of the "P".
      final bowl = Path()
        ..moveTo(21, 25)
        ..cubicTo(35.5, 21.5, 39.5, 29.5, 35.5, 35.5)
        ..cubicTo(32, 40.5, 21, 39.5, 21, 37.5);
      canvas.drawPath(bowl, body);

      // Legs — a gentle standing pose.
      final legs = Paint()
        ..color = color
        ..strokeWidth = 5.6
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(const Offset(21, 47), const Offset(15.5, 58.5), legs);
      canvas.drawLine(const Offset(21, 47), const Offset(27, 57.5), legs);

      if (withSparkle) {
        // Tiny sparkle floating above the raised hand.
        final sparkle = Path()
          ..moveTo(47, 5)
          ..quadraticBezierTo(47.9, 13.5, 56.5, 14.5)
          ..quadraticBezierTo(47.9, 15.5, 47, 24)
          ..quadraticBezierTo(46.1, 15.5, 37.5, 14.5)
          ..quadraticBezierTo(46.1, 13.5, 47, 5)
          ..close();
        canvas.drawPath(sparkle, Paint()..color = sparkleColor);
      }
    });
  }

  @override
  bool shouldRepaint(covariant _PoseLogoPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.sparkleColor != sparkleColor ||
      oldDelegate.withSparkle != withSparkle;
}

/// A tall, graceful line-art figure used as decorative illustration
/// (hero section, empty states). The raised hand holds a tiny sparkle.
class PoseFigure extends StatelessWidget {
  final double height;
  final Color color;
  final Color sparkleColor;

  const PoseFigure({
    super.key,
    this.height = 220,
    this.color = AppColors.softRose,
    this.sparkleColor = AppColors.dustyRose,
  });

  @override
  Widget build(BuildContext context) {
    // Design grid is 100x140; width follows the aspect ratio.
    final width = height * (100 / 140);
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _PoseFigurePainter(color: color, sparkleColor: sparkleColor),
      ),
    );
  }
}

class _PoseFigurePainter extends CustomPainter {
  final Color color;
  final Color sparkleColor;

  _PoseFigurePainter({required this.color, required this.sparkleColor});

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 100;
    final sy = size.height / 140;

    canvas.save();
    canvas.scale(sx, sy);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Head.
    canvas.drawCircle(const Offset(50, 17), 9.5, paint);

    // Spine with a soft S-curve.
    final spine = Path()
      ..moveTo(50, 28)
      ..cubicTo(47.5, 46, 53, 66, 50, 86);
    canvas.drawPath(spine, paint);

    // Raised arm reaching up toward the sparkle.
    final raisedArm = Path()
      ..moveTo(46.5, 38)
      ..cubicTo(36, 31, 30, 20, 33, 10);
    canvas.drawPath(raisedArm, paint);

    // Other arm relaxed at the side.
    final arm = Path()
      ..moveTo(53.5, 38)
      ..cubicTo(61, 45, 63.5, 54, 60.5, 62);
    canvas.drawPath(arm, paint);

    // Legs — one straight, one gently bent for a relaxed stance.
    final legLeft = Path()
      ..moveTo(50, 86)
      ..cubicTo(46.5, 102, 44, 114, 40.5, 125);
    canvas.drawPath(legLeft, paint);

    final legRight = Path()
      ..moveTo(50, 86)
      ..cubicTo(56.5, 100, 61, 110, 65.5, 119);
    canvas.drawPath(legRight, paint);

    // Sparkle hovering above the raised hand.
    final sparkle = Path()
      ..moveTo(33, 1.5)
      ..quadraticBezierTo(34.2, 8.5, 41.5, 9.5)
      ..quadraticBezierTo(34.2, 10.5, 33, 17.5)
      ..quadraticBezierTo(31.8, 10.5, 24.5, 9.5)
      ..quadraticBezierTo(31.8, 8.5, 33, 1.5)
      ..close();
    canvas.drawPath(sparkle, Paint()..color = sparkleColor);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PoseFigurePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.sparkleColor != sparkleColor;
}

/// A small pulsing AI sparkle badge.
///
/// The animation is deliberately gentle — a premium app should feel
/// calm, not like a game.
class Sparkle extends StatefulWidget {
  final double size;
  final Color color;

  const Sparkle({super.key, this.size = 18, this.color = AppColors.dustyRose});

  @override
  State<Sparkle> createState() => _SparkleState();
}

class _SparkleState extends State<Sparkle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
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
        final t = _controller.value;
        final scale = 0.88 + 0.12 * t;
        final opacity = 0.65 + 0.35 * t;
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: PoseIcon(
        PoseIconType.sparkle,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}

/// Soft pastel blob used as a decorative backdrop for illustrations.
class PoseBlob extends StatelessWidget {
  final double size;
  final Color color;

  const PoseBlob({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 5,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size * 0.62),
            topRight: Radius.circular(size * 0.38),
            bottomLeft: Radius.circular(size * 0.42),
            bottomRight: Radius.circular(size * 0.58),
          ),
        ),
      ),
    );
  }
}
