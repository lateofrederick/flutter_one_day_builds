import 'package:flutter/material.dart';
import 'package:timer/components/circular_painter.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
  }

  String get formattedTime {
    Duration duration = _controller.duration * _controller.value;
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
  }

  bool _isAnimating = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => CustomPaint(
                          painter: CircularPainter(
                              _controller, Colors.blue, Colors.white),
                        ),
                      )),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) => Text(
                                formattedTime,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FloatingActionButton.extended(
                        onPressed: () {
                          if (_controller.isAnimating) {
                            _controller.stop();
                            setState(() {
                              _isAnimating = !_isAnimating;
                            });
                          } else {
                            _controller.reverse(
                                from: _controller.value == 0.0
                                    ? 1.0
                                    : _controller.value);
                          }
                        },
                        icon: Icon((_controller.isAnimating && _isAnimating) || (_controller.isAnimating)
                            ? Icons.pause
                            : Icons.play_arrow),
                        label:
                            Text(_controller.isAnimating ? "Pause" : "Play"));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
