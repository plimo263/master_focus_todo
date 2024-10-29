import 'package:flutter/material.dart';

class MinuteSecondPicker extends StatefulWidget {
  final int seconds;
  final int minutes;
  final Function(Duration) onTimeSelected;

  const MinuteSecondPicker({
    super.key,
    required this.onTimeSelected,
    this.seconds = 0,
    this.minutes = 0,
  });

  @override
  _MinuteSecondPickerState createState() => _MinuteSecondPickerState();
}

class _MinuteSecondPickerState extends State<MinuteSecondPicker> {
  int _selectedMinute = 0;
  int _selectedSecond = 0;

  @override
  void initState() {
    super.initState();
    _selectedMinute = widget.minutes;
    _selectedSecond = widget.seconds;
  }

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme.displaySmall;
    const iconSize = 36.0;
    const itemHeight = 96.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          iconSize: iconSize,
          itemHeight: itemHeight,
          style: styleText,
          value: _selectedMinute,
          items: List.generate(60, (index) => index)
              .map((minute) => DropdownMenuItem(
                    value: minute,
                    child: Text(minute.toString().padLeft(2, '0')),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedMinute = value!;
              widget.onTimeSelected(
                  Duration(minutes: _selectedMinute, seconds: _selectedSecond));
            });
          },
        ),
        const SizedBox(width: 8),
        Text(
          ':',
          style: styleText,
        ),
        const SizedBox(width: 8),
        DropdownButton<int>(
          iconSize: iconSize,
          itemHeight: itemHeight,
          style: styleText,
          value: _selectedSecond,
          items: List.generate(60, (index) => index)
              .map((second) => DropdownMenuItem(
                    value: second,
                    child: Text(second.toString().padLeft(2, '0')),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedSecond = value!;
              widget.onTimeSelected(
                  Duration(minutes: _selectedMinute, seconds: _selectedSecond));
            });
          },
        ),
      ],
    );
  }
}
