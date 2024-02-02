import 'package:flutter/material.dart';

class TextOutline extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final Color outlineColor;
  final double outlineThickness;

  const TextOutline({
    super.key,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.outlineColor,
    required this.outlineThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: outlineColor,
            offset: Offset(-outlineThickness, -outlineThickness),
          ),
          Shadow(
            color: outlineColor,
            offset: Offset(outlineThickness, -outlineThickness),
          ),
          Shadow(
            color: outlineColor,
            offset: Offset(-outlineThickness, outlineThickness),
          ),
          Shadow(
            color: outlineColor,
            offset: Offset(outlineThickness, outlineThickness),
          ),
        ],
      ),
    );
  }
}
