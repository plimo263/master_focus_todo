import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/sounds_path.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/utils/bottom_sheet_custom.dart';
import 'package:master_focus_todo/widgets/app_bar_custom.dart';
import 'package:master_focus_todo/widgets/confirm_widget.dart';
import 'package:master_focus_todo/widgets/music_playing.dart';
import 'package:master_focus_todo/widgets/row_tomato_chrono.dart';
import 'package:master_focus_todo/widgets/timer_view.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

final strings = {
  'app_title_interval': 'Hora do intervalo',
  'app_title': 'Tarefa em foco',
  'label_btn_pause': 'PAUSAR',
  'label_btn_play': 'CONTINUAR',
  'label_btn_step_short_break': 'PULAR',
  'title_confirm_exit': 'Atenção',
  'subtitle_confirm_exit':
      'Você realmente deseja realmente sair da atividade ?',
};

class FocusScreen extends StatefulWidget {
  static const routeName = 'focus_screen';
  final TodoTask task;
  const FocusScreen({super.key, required this.task});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  final _player = AudioPlayer();
  bool isRunning = false;
  TodoTimer? timerRest;
  int _intervalDefault = 300;
  int _musicId = 1;

  @override
  void initState() {
    super.initState();
    widget.task.timerActual.isRunning = isRunning;
    Future.microtask(() {
      final controller =
          Provider.of<TodoConfigsController>(context, listen: false);

      _intervalDefault = controller.shortBreakSecondsTimeDefault;
      _musicId = controller.soundClock;
      _playMusic();
      setState(() {});
    });
    //
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playMusic() {
    final source = AssetSource(sounds[_musicId]);
    _player.setReleaseMode(ReleaseMode.loop);
    _player.play(source);
    _player.pause();
  }

  void _playStop() {
    setState(() {
      isRunning = !isRunning;
      _getTimer().isRunning = isRunning;
      _controlAudio();
    });
  }

  void _controlAudio() {
    if (!isRunning || timerRest != null) {
      _player.pause();
    } else {
      _player.resume();
    }
  }

  String _getTitleApp() {
    return timerRest != null
        ? strings['app_title_interval']!
        : strings['app_title']!;
  }

  TodoTimer _getTimer() {
    return timerRest != null ? timerRest! : widget.task.timerActual;
  }

  String _getLabelButton() {
    return strings[isRunning ? 'label_btn_pause' : 'label_btn_play']!;
  }

  IconData _getIconButton() {
    return isRunning ? Icons.pause : Icons.play_arrow;
  }

  Future<void> _onTimeFinished() async {
    isRunning = false;

    _toggleRestOrFocus();
    _resetTimerOrCompleted();

    await _vibrate();

    await _isCompleted();

    _controlAudio();
    setState(() {});
  }

  void _resetTimerOrCompleted() {
    if (widget.task.pomodoroCompleted < widget.task.pomodoros) {
      widget.task.timerActual.reset();
    } else {
      widget.task.isCompleted = true;
    }
  }

  void _toggleRestOrFocus() {
    if (timerRest != null) {
      timerRest = null;
    } else {
      widget.task.pomodoroCompleted++;
      timerRest = TodoTimer(
        secondsElapsed: 0,
        secondsTotal: _intervalDefault,
      );
    }
  }

  Future<void> _isCompleted() async {
    if (widget.task.isCompleted) {
      Navigator.pop(context, widget.task);
    }
  }

  Future<void> _vibrate() async {
    final canVibrate = await Vibration.hasVibrator();
    if (canVibrate != null && canVibrate) {
      Vibration.vibrate(duration: 500);
    }
  }

  Color _getColor() {
    return timerRest != null ? Colors.green : Colors.red;
  }

  Color _getBackgroundColor() {
    return timerRest != null ? Colors.green[100]! : Colors.red[100]!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _getTimer().isRunning = false;
          isRunning = false;
          _controlAudio();
        });
        return getBottomSheet<bool>(
          context,
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ConfirmWidget(
                title: strings['title_confirm_exit']!,
                subtitle: strings['subtitle_confirm_exit']!,
                onConfirm: () {
                  Navigator.pop(context, true);
                },
                onCancel: () {
                  Navigator.pop(context, false);
                }),
          ),
          minHeight: 0.2,
          maxHeight: 0.3,
        ).then((val) {
          if (val != null && val) {
            Navigator.pop(context, widget.task);
            return val;
          } else {
            setState(() {
              _getTimer().isRunning = true;
              isRunning = true;
              _controlAudio();
            });
            return false;
          }
        });
      },
      child: Scaffold(
        appBar: AppBarCustom(
          title: _getTitleApp(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const MusicPlaying(),
              RowTomatoChrono(
                totalTomatos: widget.task.pomodoros,
                tomatoFinished: widget.task.pomodoroCompleted,
              ),
              TimerViewWidget(
                timer: timerRest != null ? timerRest! : widget.task.timerActual,
                onTimerEnd: _onTimeFinished,
                color: _getColor(),
                backgroundColor: _getBackgroundColor(),
              ),
              Row(
                children: [
                  timerRest != null
                      ? Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: OutlinedButton.icon(
                                onPressed: _onTimeFinished,
                                label: Text(
                                    strings['label_btn_step_short_break']!),
                                icon: const Icon(Icons.skip_next),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getColor(),
                          ),
                          onPressed: _playStop,
                          label: Text(_getLabelButton()),
                          icon: Icon(_getIconButton()),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
