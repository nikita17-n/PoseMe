import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// The PoseMe icon set.
///
/// Every icon is drawn on a 24x24 grid with a consistent thin stroke,
/// round caps and round joins so the whole set feels like one family.
enum PoseIconType {
  home,
  pose,
  camera,
  gallery,
  upload,
  sparkle,
  analyze,
  body,
  favorite,
  history,
  settings,
  profile,
  back,
  flash,
  flip,
  capture,
  close,
  help,
  check,
  poseMatch,
}

/// A single PoseMe line icon.
///
/// ```dart
/// const PoseIcon(PoseIconType.sparkle, size: 20, color: AppColors.dustyRose)
/// ```
class PoseIcon extends StatelessWidget {
  final PoseIconType type;
  final double size;
  final Color? color;

  const PoseIcon(this.type, {super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColors.deepPlum;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PoseIconPainter(type: type, color: iconColor),
      ),
    );
  }
}

class _PoseIconPainter extends CustomPainter {
  final PoseIconType type;
  final Color color;

  _PoseIconPainter({required this.type, required this.color});

  static const double _stroke = 1.8;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (type) {
      case PoseIconType.home:
        _home(canvas, paint);
      case PoseIconType.pose:
        _pose(canvas, paint);
      case PoseIconType.camera:
        _camera(canvas, paint);
      case PoseIconType.gallery:
        _gallery(canvas, paint);
      case PoseIconType.upload:
        _upload(canvas, paint);
      case PoseIconType.sparkle:
        _sparkle(canvas, fill);
      case PoseIconType.analyze:
        _analyze(canvas, paint);
      case PoseIconType.body:
        _body(canvas, paint);
      case PoseIconType.favorite:
        _heart(canvas, paint);
      case PoseIconType.history:
        _history(canvas, paint);
      case PoseIconType.settings:
        _settings(canvas, paint);
      case PoseIconType.profile:
        _profile(canvas, paint);
      case PoseIconType.back:
        _back(canvas, paint);
      case PoseIconType.flash:
        _flash(canvas, fill);
      case PoseIconType.flip:
        _flip(canvas, paint);
      case PoseIconType.capture:
        _capture(canvas, paint);
      case PoseIconType.close:
        _close(canvas, paint);
      case PoseIconType.help:
        _help(canvas, paint, fill);
      case PoseIconType.check:
        _check(canvas, paint);
      case PoseIconType.poseMatch:
        _poseMatch(canvas, paint);
    }
  }

  // ------------------------------- icons ---------------------------------

  void _home(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(3.8, 10.4)
      ..lineTo(12, 3.4)
      ..lineTo(20.2, 10.4)
      ..moveTo(6, 9.6)
      ..lineTo(6, 20.2)
      ..lineTo(18, 20.2)
      ..lineTo(18, 9.6)
      ..moveTo(10, 20.2)
      ..lineTo(10, 15.2)
      ..lineTo(14, 15.2)
      ..lineTo(14, 20.2);
    canvas.drawPath(path, paint);
  }

  void _pose(Canvas canvas, Paint paint) {
    // A figure striking a pose — one arm lifted, one leg crossed.
    final path = Path()
      ..addOval(Rect.fromCircle(center: const Offset(12, 5.2), radius: 2.4))
      ..moveTo(12, 8)
      ..lineTo(12, 14.6)
      ..moveTo(12, 9.8)
      ..lineTo(16.8, 6.4)
      ..moveTo(12, 9.8)
      ..lineTo(7.6, 13.2)
      ..moveTo(12, 14.6)
      ..lineTo(8.4, 20.6)
      ..moveTo(12, 14.6)
      ..lineTo(15.8, 19.8);
    canvas.drawPath(path, paint);
  }

  void _camera(Canvas canvas, Paint paint) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(3, 7, 18, 13),
          const Radius.circular(3.2),
        ),
      )
      ..moveTo(8.8, 7)
      ..lineTo(10.2, 4.6)
      ..lineTo(13.8, 4.6)
      ..lineTo(15.2, 7);
    canvas.drawPath(path, paint);
    canvas.drawCircle(const Offset(12, 13.4), 3.1, paint);
  }

  void _gallery(Canvas canvas, Paint paint) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(3.4, 5, 17.2, 14),
          const Radius.circular(2.6),
        ),
      )
      ..moveTo(5.6, 16.8)
      ..lineTo(9.4, 12.4)
      ..lineTo(11.8, 14.8)
      ..lineTo(14.2, 11.6)
      ..lineTo(18.4, 16.8);
    canvas.drawPath(path, paint);
    canvas.drawCircle(const Offset(8.6, 9.8), 1.5, paint);
  }

  void _upload(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(12, 19.4)
      ..lineTo(12, 7.4)
      ..moveTo(8.2, 11.2)
      ..lineTo(12, 7.4)
      ..lineTo(15.8, 11.2)
      ..moveTo(4.8, 14.6)
      ..lineTo(4.8, 18.6)
      ..lineTo(19.2, 18.6)
      ..lineTo(19.2, 14.6);
    canvas.drawPath(path, paint);
  }

  void _sparkle(Canvas canvas, Paint paint) {
    // Elegant four-point star.
    final path = Path()
      ..moveTo(12, 2.8)
      ..quadraticBezierTo(12.7, 10.6, 21.2, 12)
      ..quadraticBezierTo(12.7, 13.4, 12, 21.2)
      ..quadraticBezierTo(11.3, 13.4, 2.8, 12)
      ..quadraticBezierTo(11.3, 10.6, 12, 2.8)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _analyze(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(3.6, 8.4)
      ..lineTo(3.6, 5.8)
      ..lineTo(6.2, 5.8)
      ..moveTo(17.8, 5.8)
      ..lineTo(20.4, 5.8)
      ..lineTo(20.4, 8.4)
      ..moveTo(3.6, 15.6)
      ..lineTo(3.6, 18.2)
      ..lineTo(6.2, 18.2)
      ..moveTo(17.8, 18.2)
      ..lineTo(20.4, 18.2)
      ..lineTo(20.4, 15.6)
      ..moveTo(7.2, 12)
      ..lineTo(16.8, 12);
    canvas.drawPath(path, paint);
  }

  void _body(Canvas canvas, Paint paint) {
    final path = Path()
      ..addOval(Rect.fromCircle(center: const Offset(12, 4.8), radius: 2.3))
      ..moveTo(12, 7.4)
      ..lineTo(12, 13.8)
      ..moveTo(6.4, 10.4)
      ..lineTo(12, 9.4)
      ..lineTo(17.6, 10.4)
      ..moveTo(12, 13.8)
      ..lineTo(8.2, 20.4)
      ..moveTo(12, 13.8)
      ..lineTo(15.8, 20.4);
    canvas.drawPath(path, paint);
  }

  void _heart(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(12, 20.4)
      ..cubicTo(4.2, 14.6, 3.4, 9.4, 6.4, 6.6)
      ..cubicTo(8.8, 4.4, 11.2, 5.6, 12, 7.6)
      ..cubicTo(12.8, 5.6, 15.2, 4.4, 17.6, 6.6)
      ..cubicTo(20.6, 9.4, 19.8, 14.6, 12, 20.4)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _history(Canvas canvas, Paint paint) {
    canvas.drawCircle(const Offset(12, 12), 8, paint);
    final hands = Path()
      ..moveTo(12, 7.6)
      ..lineTo(12, 12)
      ..lineTo(15.2, 14.2);
    canvas.drawPath(hands, paint);
    // Small rewind arrow at the top of the clock.
    final arrow = Path()
      ..moveTo(12, 3.4)
      ..lineTo(10.6, 5.4)
      ..lineTo(13.4, 5.4)
      ..close();
    canvas.drawPath(arrow, paint);
  }

  void _settings(Canvas canvas, Paint paint) {
    canvas.drawCircle(const Offset(12, 12), 3, paint);
    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final inner = 12 + 4.6 * math.cos(angle);
      final outer = 12 + 7.4 * math.cos(angle);
      final path = Path()
        ..moveTo(inner, 12 + 4.6 * math.sin(angle))
        ..lineTo(outer, 12 + 7.4 * math.sin(angle));
      canvas.drawPath(path, paint);
    }
  }

  void _profile(Canvas canvas, Paint paint) {
    canvas.drawCircle(const Offset(12, 8.4), 3.2, paint);
    final shoulders = Path()
      ..moveTo(4.8, 20)
      ..cubicTo(4.8, 14.6, 8.4, 13.4, 12, 13.4)
      ..cubicTo(15.6, 13.4, 19.2, 14.6, 19.2, 20);
    canvas.drawPath(shoulders, paint);
  }

  void _back(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(14.6, 4.8)
      ..lineTo(7.8, 12)
      ..lineTo(14.6, 19.2);
    canvas.drawPath(path, paint);
  }

  void _flash(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(13.6, 2.8)
      ..lineTo(6.8, 13.4)
      ..lineTo(10.8, 13.4)
      ..lineTo(9.8, 21.2)
      ..lineTo(16.4, 10.8)
      ..lineTo(12.4, 10.8)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _flip(Canvas canvas, Paint paint) {
    final top = Path()
      ..moveTo(5.4, 9.6)
      ..arcToPoint(const Offset(18.6, 14.4), radius: const Radius.circular(8))
      ..moveTo(18.6, 14.4)
      ..moveTo(15.4, 13.4)
      ..lineTo(18.6, 14.4)
      ..lineTo(17.2, 17.4);
    canvas.drawPath(top, paint);

    final bottom = Path()
      ..moveTo(18.6, 14.4)
      ..arcToPoint(const Offset(5.4, 9.6), radius: const Radius.circular(8))
      ..moveTo(5.4, 9.6)
      ..moveTo(8.6, 10.6)
      ..lineTo(5.4, 9.6)
      ..lineTo(6.8, 6.6);
    canvas.drawPath(bottom, paint);
  }

  void _capture(Canvas canvas, Paint paint) {
    canvas.drawCircle(const Offset(12, 12), 8.4, paint);
    canvas.drawCircle(const Offset(12, 12), 5.2, paint);
  }

  void _close(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(6.2, 6.2)
      ..lineTo(17.8, 17.8)
      ..moveTo(17.8, 6.2)
      ..lineTo(6.2, 17.8);
    canvas.drawPath(path, paint);
  }

  void _help(Canvas canvas, Paint paint, Paint fill) {
    canvas.drawCircle(const Offset(12, 12), 8.4, paint);
    final question = Path()
      ..moveTo(9.4, 9.4)
      ..cubicTo(9.4, 7.4, 14.6, 7.4, 14.6, 9.8)
      ..cubicTo(14.6, 11.4, 12.2, 11.8, 12.2, 14);
    canvas.drawPath(question, paint);
    canvas.drawCircle(const Offset(12.2, 16.8), 0.95, fill);
  }

  void _check(Canvas canvas, Paint paint) {
    final path = Path()
      ..moveTo(4.8, 12.6)
      ..lineTo(9.8, 17.4)
      ..lineTo(19.2, 6.6);
    canvas.drawPath(path, paint);
  }

  void _poseMatch(Canvas canvas, Paint paint) {
    final figure = Path()
      ..addOval(Rect.fromCircle(center: const Offset(8.6, 6.2), radius: 2.2))
      ..moveTo(8.6, 8.8)
      ..lineTo(8.6, 13.6)
      ..moveTo(5, 10.8)
      ..lineTo(8.6, 9.8)
      ..lineTo(12.2, 10.8)
      ..moveTo(8.6, 13.6)
      ..lineTo(6.2, 19.2)
      ..moveTo(8.6, 13.6)
      ..lineTo(11, 19.2);
    canvas.drawPath(figure, paint);

    // Check badge.
    canvas.drawCircle(const Offset(17.4, 17.4), 3.6, paint);
    final check = Path()
      ..moveTo(15.8, 17.4)
      ..lineTo(17, 18.6)
      ..lineTo(19.2, 16.2);
    canvas.drawPath(check, paint);
  }

  @override
  bool shouldRepaint(covariant _PoseIconPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.color != color;
}
