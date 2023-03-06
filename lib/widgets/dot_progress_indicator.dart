import 'package:flutter/material.dart';

class DotProgressIndicator extends StatelessWidget {
  final int? progress;
  final Color activeColor;
  final Color inactiveColor;

  const DotProgressIndicator({
    super.key,
    required this.progress,
    this.activeColor = const Color(0xFFFFFFFF),
    this.inactiveColor = const Color(0xFF605E6A),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: progress == 0 ? 1.0 : 0.8,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: progress == 0 ? activeColor : inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Transform.scale(
            scale: progress == 1 ? 1.0 : 0.8,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: progress == 1 ? activeColor : inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Transform.scale(
            scale: progress == 2 ? 1.0 : 0.8,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: progress == 2 ? activeColor : inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
