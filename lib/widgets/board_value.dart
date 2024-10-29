import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardValue extends StatelessWidget {
  final String label;
  final String value;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const BoardValue({
    super.key,
    required this.label,
    required this.value,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final styleLabel = GoogleFonts.inter(fontSize: 16);
    final styleValue = GoogleFonts.orbitron(fontSize: 28, letterSpacing: 2);
    return Card(
      elevation: 4,
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AutoSizeText(
              label,
              style: styleLabel,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            if (icon != null) Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: styleValue,
            ),
          ],
        ),
      ),
    );
  }
}
