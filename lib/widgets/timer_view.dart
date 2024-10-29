import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_focus_todo/models/todo_timer.dart';

class TimerViewWidget extends StatefulWidget {
  final TodoTimer timer;
  final Function? onTimerEnd;
  final Color? color;
  final Color? backgroundColor;
  const TimerViewWidget({
    super.key,
    required this.timer,
    this.onTimerEnd,
    this.color = Colors.red,
    this.backgroundColor,
  });

  @override
  State<TimerViewWidget> createState() => _TimerViewWidgetState();
}

class _TimerViewWidgetState extends State<TimerViewWidget> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _counter();
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  /// Executa o contador do tempo sempre fazendo o calculo do tempo restante
  void _counter() {
    try {
      widget.timer.ticTac();
    } catch (e) {
      if (widget.onTimerEnd != null) {
        widget.onTimerEnd!();
      }
    }
  }

  Color _getColor() {
    return widget.color!;
  }

  Color _getBackgroundColor() {
    return widget.backgroundColor != null
        ? widget.backgroundColor!
        : Colors.red.shade100;
  }

  @override
  Widget build(BuildContext context) {
    const width = 100 * pi;
    const height = 100 * pi;
    final textDisplay = GoogleFonts.orbitron(
      fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
    );

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 1,
              end: widget.timer.remainingTime() / widget.timer.secondsTotal,
            ),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return CircularProgressIndicator(
                value: value,
                strokeWidth: 12,
                backgroundColor: _getBackgroundColor(),
                color: _getColor(),
              );
            },
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 4 + 8,
          top: MediaQuery.of(context).size.height / 6 + 12,
          child: Text(
            widget.timer.formatTime(
              widget.timer.remainingTime(),
            ),
            style: textDisplay,
          ),
        ),
      ],
    );
  }
}
