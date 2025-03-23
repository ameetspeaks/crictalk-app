import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLogo({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cricket bat
            Positioned(
              left: size * 0.25,
              child: Transform.rotate(
                angle: -0.3,
                child: Container(
                  width: size * 0.15,
                  height: size * 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(size * 0.05),
                  ),
                ),
              ),
            ),
            
            // Cricket ball
            Positioned(
              right: size * 0.25,
              top: size * 0.3,
              child: Container(
                width: size * 0.25,
                height: size * 0.25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: size * 0.12,
                    height: size * 0.02,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(size * 0.01),
                    ),
                  ),
                ),
              ),
            ),
            
            // Wicket
            Positioned(
              bottom: size * 0.15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: size * 0.02),
                    width: size * 0.05,
                    height: size * 0.3,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(size * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            
            // Bails
            Positioned(
              bottom: size * 0.45,
              child: Container(
                width: size * 0.3,
                height: size * 0.04,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(size * 0.02),
                ),
              ),
            ),
            
            // Letter S
            Positioned(
              top: size * 0.15,
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

