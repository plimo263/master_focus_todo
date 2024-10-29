import 'package:flutter/material.dart';

const strings = {
  'label_confirm': 'CONFIRMAR',
  'label_cancel': 'CANCELAR',
};

class ConfirmWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onConfirm;
  final Function() onCancel;
  const ConfirmWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.headlineSmall;
    final styleSubtitle = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: styleTitle),
          const SizedBox(height: 8),
          Text(subtitle, style: styleSubtitle),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                    onPressed: onCancel,
                    child: Text(strings['label_cancel']!),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: Text(strings['label_confirm']!),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
