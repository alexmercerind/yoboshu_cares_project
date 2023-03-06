import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:yoboshu_cares_project/utils/theme.dart';
import 'package:yoboshu_cares_project/widgets/buttons.dart';
import 'package:yoboshu_cares_project/widgets/circular_timer.dart';
import 'package:yoboshu_cares_project/widgets/dot_progress_indicator.dart';

class MindfulMealTimer extends StatefulWidget {
  const MindfulMealTimer({Key? key}) : super(key: key);

  @override
  State<MindfulMealTimer> createState() => _MindfulMealTimerState();
}

class _MindfulMealTimerState extends State<MindfulMealTimer> {
  /// Progress.
  /// The `null` value indicates that timer has not started yet.
  int? progress;

  /// [CircularTimerController] instance to controller the [CircularTimer].
  late final controller = CircularTimerController(
    onComplete: () {
      next();
    },
    duration: const Duration(seconds: 30),
    tickingSoundDuration: const Duration(seconds: 5),
  );

  // NOTE: Ideally these UI labels must be taken from a localization file.

  String get title {
    if (progress == 0) {
      return 'Nom nom :)';
    }
    if (progress == 1) {
      return 'Break Time';
    }
    if (progress == 2) {
      return 'Finish your meal';
    }
    return 'Time to eat mindfully';
  }

  String get subtitle {
    if (progress == 0) {
      return 'You have 10 minutes to eat before the pause.\nFocus on eating slowly';
    }
    if (progress == 1) {
      return 'Take a five minute break to check in on your level of fullness';
    }
    if (progress == 2) {
      return 'You can eat untill you feel full';
    }
    return 'It\'s simple: eat slowly for ten minutes, rest for five, then finish your meal';
  }

  String get label {
    if (progress == null) {
      return 'START';
    }
    return controller.paused ? 'RESUME' : 'PAUSE';
  }

  void action() {
    if (progress == null) {
      controller.resume();
      progress = 0;
    } else {
      if (controller.paused) {
        controller.resume();
      } else {
        controller.pause();
      }
    }
    setState(() {});
  }

  void reset() {
    progress = null;
    controller.reset();
    setState(() {});
  }

  void next() {
    if (progress == 2) {
      // The 3 steps are completed.
      // Restore to initial state.
      reset();
    } else {
      // Move to next step & re-start the timer.
      if (progress != null) {
        progress = progress! + 1;
      }
      controller.reset();
      controller.resume();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        shadowColor: kAppBarShadowColor,
        elevation: 1.0,
        // By default, Flutter automatically implies leading button.
        leading: IconButton(
          onPressed: () {
            // N/A
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          splashRadius: 20.0,
        ),
        title: const Text(
          'Mindful Meal Timer',
          style: TextStyle(color: kTextSecondaryColor),
        ),
        backgroundColor: kScaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DotProgressIndicator(progress: progress),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: kTextPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: kTextSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: CircularTimer(
                controller: controller,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          CupertinoSwitch(
            value: controller.tickingSoundDuration > Duration.zero,
            onChanged: (e) {
              if (e) {
                controller.tickingSoundDuration =
                    kCircularTimerDefaultTickingSoundDuration;
              } else {
                controller.tickingSoundDuration = Duration.zero;
              }
              setState(() {});
            },
          ),
          const SizedBox(height: 2.0),
          Text(
            'Sound ${controller.tickingSoundDuration > Duration.zero ? 'On' : 'Off'}',
            style: const TextStyle(
              fontSize: 14.0,
              color: kTextPrimaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  onPressed: action,
                  text: label,
                ),
                if (progress != null) ...[
                  const SizedBox(height: 12.0),
                  SecondaryButton(
                    onPressed: reset,
                    text: 'LET\'S STOP I\'M FULL NOW',
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
