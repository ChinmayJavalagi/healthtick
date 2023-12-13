import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healthtick/screens/page2.dart';

import '../utils/constants.dart';

class Page0 extends StatefulWidget {
  final Function(int) onPageSelected;

  const Page0({Key? key, required this.onPageSelected}) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  bool _lights = true;

  final int _duration = 30;

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text('Time to eat mindfully', style: kMainTextStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20, right:20, bottom: 5, top: 10.0),
              child: Center(
                child: Text(
                  'It\'s simple: eat slowly for ten minutes, rest for five, and then finish you meal',
                  style: kSubTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: CircularCountDownTimer(
                // Countdown duration in Seconds.
                duration: _duration,

                // Countdown initial elapsed Duration in Seconds.
                initialDuration: 0,

                // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                controller: _controller,

                // Width of the Countdown Widget.
                width: MediaQuery.of(context).size.width / 2,

                // Height of the Countdown Widget.
                height: MediaQuery.of(context).size.height / 2,

                // Ring Gradient for Countdown Widget.
                ringGradient: null,

                // Filling Gradient for Countdown Widget.
                fillGradient: null,

                // Background Gradient for Countdown Widget.
                backgroundGradient: null,
                ringColor: Colors.grey[400]!,
                fillColor: Colors.green!,
                backgroundColor: Color(0xff110019),
                // Border Thickness of the Countdown Ring.
                strokeWidth: 14.0,

                // Begin and end contours with a flat edge and no extension.
                strokeCap: StrokeCap.round,

                // Text Style for Countdown Text.
                textStyle: const TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),

                // Format for the Countdown Text.
                textFormat: CountdownTextFormat.S,

                // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                isReverse: true,

                // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                isReverseAnimation: true,

                // Handles visibility of the Countdown Text.
                isTimerTextShown: true,

                // Handles the timer start.
                autoStart: false,

                // This Callback will execute when the Countdown Starts.
                onStart: () {
                  // Here, do whatever you want
                  debugPrint('Countdown Started');
                },

                // This Callback will execute when the Countdown Ends.
                onComplete: () {
                  // Here, do whatever you want
                  debugPrint('Countdown Ended');
                },

                // This Callback will execute when the Countdown Changes.
                onChange: (String timeStamp) {
                  // Here, do whatever you want
                  debugPrint('Countdown Changed $timeStamp');
                },

                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
                  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
                  return '$minutes:$seconds';
                },
              ),
            ),// for stopwatch
            Center(
              child: CupertinoSwitch(
                value: _lights,
                activeColor: Color(0xff99ada1),
                trackColor: Colors.grey,
                dragStartBehavior: DragStartBehavior.start,
                onChanged: (bool value) {
                  setState(() {
                    _lights = value;
                  });
                },
              ),
            ),
            Center(
                child: Text(
                  'Sound on',
                  style: kSoundTextStyle,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 22.0, left: 30, right: 30.0),
              child: ElevatedButton(
                child: Text('START '),
                onPressed: () {
                  widget.onPageSelected(1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff99ada1),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                    textStyle: kButtonTextStyle),
              ),
            ),
          ],
        )
    );
  }
}