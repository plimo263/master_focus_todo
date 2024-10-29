import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:master_focus_todo/constants/images_path.dart';

class RowTomatoChrono extends StatelessWidget {
  final int totalTomatos;
  final int tomatoFinished;
  const RowTomatoChrono({
    super.key,
    required this.totalTomatos,
    this.tomatoFinished = 0,
  });
  List<Widget> _chronos() {
    return [
      SvgPicture.asset(
        tomatoImg,
        width: 64,
        height: 64,
      ),
      Text('$tomatoFinished / $totalTomatos'),
    ];
  }

  List<Widget> _buildChronos() {
    final chronos = <Widget>[];
    if (_isGreaterLimit()) return _chronos();

    for (var i = 0; i < totalTomatos; i++) {
      chronos.add(
        SvgPicture.asset(
          i < tomatoFinished ? tomatoImg : tomatoIncomplete,
          width: 64,
          height: 64,
        ),
      );
    }
    return chronos;
  }

  bool _isGreaterLimit() {
    return totalTomatos > 5;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isGreaterLimit()
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceAround,
      children: _buildChronos(),
    );
  }
}
