import 'dart:async';

import 'package:flutter/material.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTimer);
    _stopwatch.start();
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  void _pauseResumeTimer() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTimer);
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
    setState(() {});
  }

  String _formattedTime(Duration duration) {
    String twoDigitMinutes = _twoDigits((duration.inMinutes.remainder(60)));
    String twoDigitSeconds = _twoDigits((duration.inSeconds.remainder(60)));
    String twoDigitHours = _twoDigits((duration.inHours));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              _formattedTime(_stopwatch.elapsed),
              style: const TextStyle(fontSize: 65),
            ),
            const Text(
              "Duracion",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "0.00",
              style: TextStyle(fontSize: 65),
            ),
            const Text(
              "Distancia",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    child: ElevatedButton(
                        onPressed: _pauseResumeTimer,
                        child: _isRunning
                            ? const Text(
                                "PAUSAR",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              )
                            : const Text(
                                "CONTINUAR",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ))),
                const SizedBox(
                  width: 1,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    child: ElevatedButton(
                        onPressed: _stopTimer,
                        child: const Text(
                          "FINALIZAR",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
