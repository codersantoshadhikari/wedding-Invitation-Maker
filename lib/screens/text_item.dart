import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final Offset offset;

  const TextItem({
    Key? key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
