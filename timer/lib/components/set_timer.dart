import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/timer.dart';

class SetTimer extends StatefulWidget {
  @override
  _SetTimerState createState() => _SetTimerState();
}

class _SetTimerState extends State<SetTimer> {
  Duration _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Column(
                children: [
                  CupertinoTimerPicker(
                    onTimerDurationChanged: (val) {
                      setState(() {
                        _time = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            top: MediaQuery.of(context).size.height * 0.35,
            right: 0,
            bottom: 0,
            left: 0,
          ),
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ElevatedButton(
                child: Text("start"),
                onPressed: () {
                  print("===============");
                  print(_time);
                  print("===============");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Timer(_time))
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: TextStyle(fontSize: 28.0)),
              ),
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
