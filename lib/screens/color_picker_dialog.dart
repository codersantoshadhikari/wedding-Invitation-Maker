import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final VoidCallback onConfirm;

  const ColorPickerDialog({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Pick a color'),
    content: SingleChildScrollView(
    child: ColorPicker(
    pickerColor: pickerColor,
    onColorChanged: onColorChanged,
    showLabel: true,
    pickerAreaHeightPercent: 0.8,
    ),
    ),
    actions: <Widget>[
    TextButton(
      child: const Text('Confirm'),
      onPressed: () {
        onConfirm();
      },
    ),
    ],
    );
  }
}

