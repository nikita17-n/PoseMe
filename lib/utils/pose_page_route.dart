import 'package:flutter/material.dart';

/// A subtle, premium screen transition: gentle fade + slight upward slide.
///
/// Used for all PoseMe navigation so screen changes feel smooth and calm
/// rather than the default platform swipe.
class PosePageRoute<T> extends PageRouteBuilder<T> {
  PosePageRoute({required WidgetBuilder builder})
    : super(
        transitionDuration: const Duration(milliseconds: 320),
        reverseTransitionDuration: const Duration(milliseconds: 240),
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.035),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      );
}
