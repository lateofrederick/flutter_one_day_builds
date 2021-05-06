import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer/components/circular_painter.dart';
import 'package:timer/components/set_timer.dart';
import 'package:timer/services/cache.dart';

class Timer extends StatefulWidget {
  final Duration _time;
  Timer(this._time);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  Cache cache = Cache();
  Duration duration;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget._time.inSeconds));
    WidgetsBinding.instance.addObserver(this);
    _controller.reverse(from: 1.0);
  }

  String get formattedTime {
    duration = _controller.duration * _controller.value;
    return "${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
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
                              _controller,  Colors.white, Colors.white,),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return FloatingActionButton.extended(
                            heroTag: "btn1",
                            backgroundColor: Colors.green,
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
                                        : _controller.value
                                );
                              }
                            },
                            icon: Icon(
                                (_controller.isAnimating && _isAnimating) ||
                                        (_controller.isAnimating)
                                    ? Icons.pause
                                    : Icons.play_arrow),
                            label: Text(
                                _controller.isAnimating ? "Pause" : "Play"));
                      }),
                  FloatingActionButton.extended(
                    heroTag: "btn2",
                    backgroundColor: Colors.green,
                      onPressed: () {
                      cache.clearLocalStorage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetTimer()));
                      },
                      label: Text("Cancel"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        cache.saveTime(formattedTime);
        break;
      case AppLifecycleState.detached:
        cache.saveTime(formattedTime);
        break;
      default:
        break;
    }
  }
}
