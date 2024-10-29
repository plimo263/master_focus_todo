import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/sounds_path.dart';
import 'package:path/path.dart' as path;

const strings = {
  'title_form_sound_default': 'Som Padrão para as tarefas',
  'subtitle_form_sound_default': 'Defina um som padrão para as tarefas',
  'label_btn_save_form_sound': 'SALVAR',
};

class FormSound extends StatefulWidget {
  final List<String> soundsAvailable = sounds;
  final void Function(int? value) onTap;
  final int? soundDefault;
  const FormSound({super.key, required this.onTap, this.soundDefault});

  @override
  State<FormSound> createState() => _FormSoundState();
}

class _FormSoundState extends State<FormSound> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int? _selectedSound = 0;

  @override
  void initState() {
    super.initState();

    _selectedSound = widget.soundDefault ?? 0;

    _audioPlayer.onPlayerStateChanged.listen((PlayerState event) {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<DropdownMenuEntry<int>> _getDropdownMenuEntries() {
    final options = <DropdownMenuEntry<int>>[];
    for (int i = 0; i < widget.soundsAvailable.length; i++) {
      options.add(DropdownMenuEntry(
          value: i,
          label: path.basenameWithoutExtension(widget.soundsAvailable[i])));
    }
    return options;
  }

  void _onConfirm() {
    widget.onTap(_selectedSound);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Column(
        children: [
          Text(
            strings['subtitle_form_sound_default']!,
          ),
          const SizedBox(height: 16),
          DropdownMenu<int>(
            width: MediaQuery.of(context).size.width - 32,
            label: Text(strings['title_form_sound_default']!),
            initialSelection: _selectedSound,
            onSelected: (int? value) => setState(() {
              _selectedSound = value!;
              final source = AssetSource(widget.soundsAvailable[value]);

              _audioPlayer.play(source);
            }),
            dropdownMenuEntries: _getDropdownMenuEntries(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: _onConfirm,
              child: Text(strings['label_btn_save_form_sound']!),
            ),
          ),
        ],
      ),
    );
  }
}
