import 'package:flutter/material.dart';

class SwitchPageDialog extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final VoidCallback onConfirm;

  const SwitchPageDialog({
    Key? key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int targetIndex = currentIndex;
    return AlertDialog(
      title: Text("Switch to Page"),
      content: TextField(
        onChanged: (value) {
          targetIndex = int.tryParse(value) ?? currentIndex;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Page Index',
          hintText: 'Enter the page index',
        ),
      ),
      actions: [
        TextButton(
          child: Text("Switch"),
          onPressed: () {
            onIndexChanged(targetIndex);
            onConfirm();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
