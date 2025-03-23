import 'package:flutter/material.dart';
import '../../config/theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool useDarkerGradient;

  const GradientBackground({
    super.key,
    required this.child,
    this.useDarkerGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: useDarkerGradient
              ? const [
                  Color(0xFFD32F2F),
                  Color(0xFF7B1FA2),
                  Color(0xFF1A237E),
                ]
              : const [
                  AppColors.gradientStart,
                  AppColors.gradientMiddle,
                  AppColors.gradientEnd,
                ],
        ),
      ),
      child: child,
    );
  }
}

