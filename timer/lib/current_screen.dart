import 'package:flutter/material.dart';
import 'package:timer/components/set_timer.dart';
import 'package:timer/services/cache.dart';
import 'package:timer/timer.dart';

class CurrentScreen extends StatefulWidget {
  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  Cache cache = Cache();
  Duration _duration;
  final initialTime = "0:00:00.000000";

  void _loadTime() async {
    try {
      Duration _time = await cache.getTimeFromCache();
      setState(() {
        _duration = _time;
      });
    } catch (err) {
      print(err);
    }
  }
  @override
  void initState() {
    super.initState();

    _loadTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _duration != null && _duration.toString() != initialTime
          ? Timer(_duration)
          : SetTimer(),
    );
  }
}
