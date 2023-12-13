import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Page2 extends StatefulWidget {
  final Function(int) onPageSelected;
  const Page2({Key? key, required this.onPageSelected}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _lights = true;
  bool isTimerRunning = false;
  bool isTimerPaused = false;
  bool hasStarted = false;
  final int _duration = 30;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  final CountDownController _controller = CountDownController();

  void playAudio(int cnt) {
    final player = AudioCache();
    player.play("countdown_tick.mp3").then((value) {
      // Check if the countdown has not ended
      print(_controller.getTime.toString(),);
      print("Hellooo00000");
      if (_controller.getTime() != '00:00') {
        // Play the audio again after a short delay
        Future.delayed(Duration(seconds: 1), () {
          if (cnt<4 && _lights){
            cnt+=1;
            playAudio(cnt);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text('Break Time', style: kMainTextStyle),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:20, right:20, bottom: 5),
              child: Center(
                child: Text(
                  'Take a five-minute break to check in on your level of fullness',
                  style: kSubTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: CircularCountDownTimer(
                duration: _duration,
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[200]!,
                fillColor: Color(0xff99ada1),
                backgroundColor: Color(0xff110019),
                strokeWidth: 14.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: false,
                onStart: () {
                  debugPrint('Countdown Started');
                  if(_lights){
                    Future.delayed(Duration(seconds: _duration - 5), () {
                      playAudio(0);
                    });}
                },
                onComplete: () {
                  widget.onPageSelected(3);
                  debugPrint('Countdown Ended');
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  String minutes =
                  (duration.inMinutes % 60).toString().padLeft(2, '0');
                  String seconds =
                  (duration.inSeconds % 60).toString().padLeft(2, '0');
                  return '$minutes:$seconds';
                },
              ),
            ),
          ), // for stopwatch
          Expanded(
            child: Column(
              children: [
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, top: 12.0, left: 30, right: 30.0),
            child: ElevatedButton(
              child: Text(
                  hasStarted ? isTimerPaused ? 'RESUME' : 'PAUSE' : 'START'),
              onPressed: () {
                if (hasStarted) {
                  if (isTimerPaused) {
                    _controller.resume();
                    setState(() {
                      isTimerPaused = false;
                    });
                  } else {
                    _controller.pause();
                    setState(() {
                      isTimerPaused = true;
                    });
                  }
                } else {
                  _controller.start();
                  setState(() {
                    hasStarted = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff99ada1),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: kButtonTextStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, top: 12.0, left: 30, right: 30.0),
            child: ElevatedButton(
              child: Text('LET\'S STOP I\'M FULL NOW'),
              onPressed: () {
                widget.onPageSelected(0);
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff110019),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade600),),
                  textStyle: kButtonTextStyle),
            ),
          )
        ],
      ),
    );
  }
}
