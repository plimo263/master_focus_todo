import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/images_path.dart';

class NoDataWidget extends StatefulWidget {
  final String message;
  const NoDataWidget({super.key, this.message = 'Nenhum dado encontrado'});

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.4;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          tomatoNotFoundTask,
          width: width,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(widget.message),
      ],
    );
  }
}
