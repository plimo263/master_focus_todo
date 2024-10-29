import 'package:flutter/material.dart';
import 'package:master_focus_todo/widgets/minute_seconds_picker.dart';

const strings = {
  'title_form_pomodoro_time_default': 'Tempo Padrão',
  'subtitle_form_pomodoro_time_default':
      'Defina um tempo padrão para o Pomodoro',
  'label_btn_save_form_pomodoro_time_default': 'SALVAR'
};

class FormSaveTimeSeconds extends StatefulWidget {
  final int seconds;
  const FormSaveTimeSeconds({super.key, required this.seconds});

  @override
  State<FormSaveTimeSeconds> createState() => _FormSaveTimeSecondsState();
}

class _FormSaveTimeSecondsState extends State<FormSaveTimeSeconds> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.seconds.toString();
  }

  TextStyle _getTitleStyle() {
    return Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 30);
  }

  TextStyle _getSubtitleStyle() {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  @override
  Widget build(BuildContext context) {
    final seconds = widget.seconds % 60;
    final minutes = (widget.seconds / 60).floor();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(strings['title_form_pomodoro_time_default']!,
              style: _getTitleStyle()),
          const SizedBox(height: 8),
          Text(strings['subtitle_form_pomodoro_time_default']!,
              style: _getSubtitleStyle()),
          MinuteSecondPicker(
              seconds: seconds,
              minutes: minutes,
              onTimeSelected: (duration) {
                _controller.text = duration.inSeconds.toString();
              }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(int.parse(_controller.text));
              },
              child:
                  Text(strings['label_btn_save_form_pomodoro_time_default']!),
            ),
          ),
        ],
      ),
    );
  }
}
