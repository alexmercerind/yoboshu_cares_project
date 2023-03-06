import 'dart:math';

import 'package:flutter/material.dart';

// Default colors used in the widget.

const kCircularTimerTicksColor = Color(0xFFC1C1C1);
const kCircularTimerBackgroundColor = Color(0xFFFFFFFF);
const kCircularTimerForegroundColor = Color(0xFF42AF54);

/// CircularTimerController
/// -----------------------
///
/// A controller for [CircularTimer] widget.
/// Provides abstraction to [resume] or [pause] the timer.
///
class CircularTimerController {
  /// Duration of the timer.
  final Duration duration;

  CircularTimerController(this.duration);

  /// Pause
  void pause() => controller?.stop();

  /// Resume
  void resume() => controller?.forward();

  /// Reference to the [AnimationController] used by [CircularTimer].
  /// Initialized within the widget itself (dependent on [TickerProviderStateMixin]).
  AnimationController? controller;
}

/// CircularTimer
/// -------------
///
/// Does not use any external dependencies.
///
class CircularTimer extends StatefulWidget {
  final double size;
  final EdgeInsets padding;
  final CircularTimerController controller;
  final TextStyle? textStyle;
  final TextStyle? subtitleTextStyle;
  const CircularTimer({
    Key? key,
    this.padding = const EdgeInsets.all(28.0),
    this.size = 200.0,
    required this.controller,
    this.textStyle,
    this.subtitleTextStyle,
  }) : super(key: key);

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller.controller = AnimationController(
      vsync: this,
      duration: widget.controller.duration,
      reverseDuration: widget.controller.duration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    widget.controller.resume();
  }

  /// Convert [Duration] to MM:SS format.
  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.size * 9.0 / 200.0;
    final stroke = widget.size * 12.0 / 200.0;
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: kCircularTimerBackgroundColor,
        borderRadius: BorderRadius.circular(
          widget.size / 2 +
              max(
                widget.padding.vertical,
                widget.padding.horizontal,
              ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ticks
          Positioned.fill(
            child: Stack(
              children: [
                for (int i = 0; i < 12 * 5; i++)
                  Center(
                    child: (widget.controller.controller != null)
                        ? Transform.rotate(
                            // Convert degrees to radians
                            angle: pi / 180 * 360 / (12 * 5) * i,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                i % (12 * 5 / 4) == 0
                                    ? -9.7 * unit
                                    : -10.2 * unit,
                              ),
                              child: AnimatedBuilder(
                                animation: widget.controller.controller!,
                                builder: (context, _) => Container(
                                  color: widget.controller.controller!.value ==
                                          1.0
                                      ? kCircularTimerTicksColor
                                      : widget.controller.controller!.value >
                                              (12 * 5 - i) / (12 * 5)
                                          ? kCircularTimerTicksColor
                                          : kCircularTimerForegroundColor,
                                  height: i % (12 * 5 / 4) == 0
                                      ? 3.0 * unit
                                      : 2.0 * unit,
                                  width: i % (12 * 5 / 4) == 0
                                      ? 0.3 * unit
                                      : 0.2 * unit,
                                ),
                              ),
                            ),
                          )
                        : null,
                  )
              ],
            ),
          ),
          SizedBox(
            width: widget.size,
            height: widget.size,
          ),
          // The general idea is to use two [CircularProgressIndicator]s & overlay them.
          Positioned.fill(
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: stroke,
              valueColor: const AlwaysStoppedAnimation<Color>(
                kCircularTimerBackgroundColor,
              ),
            ),
          ),
          if (widget.controller.controller != null)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: widget.controller.controller!,
                builder: (context, _) => CircularProgressIndicator(
                  value:
                      (1 - widget.controller.controller!.value).clamp(0.0, 1.0),
                  strokeWidth: stroke,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    kCircularTimerForegroundColor,
                  ),
                ),
              ),
            ),
          if (widget.controller.controller != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: widget.controller.controller!,
                  builder: (context, _) => Text(
                    _format(
                      widget.controller.duration *
                          (1 - widget.controller.controller!.value),
                    ),
                    style: widget.textStyle ??
                        const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  'minutes remaining',
                  style: widget.textStyle ??
                      const TextStyle(
                        fontSize: 18.0,
                        color: kCircularTimerTicksColor,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
