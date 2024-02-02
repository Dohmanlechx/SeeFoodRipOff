import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:object_detection_ssd_mobilenet/text_outline.dart';

class EvaluatingScreen extends StatelessWidget {
  final Uint8List image;

  const EvaluatingScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.memory(image, fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.grey.withOpacity(0.80), // Adjust opacity as needed
          ),
        ),
        const Center(
          child: Stack(
            children: [
              TextOutline(
                text: 'Evaluating...',
                textColor: Colors.white,
                fontSize: 32,
                outlineColor: Colors.black,
                outlineThickness: 1.5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
