import 'dart:typed_data';
import 'package:flutter/material.dart';

class HotdogScreen extends StatelessWidget {
  final Uint8List image;
  final VoidCallback onStart;

  const HotdogScreen({
    super.key,
    required this.image,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.memory(image, fit: BoxFit.cover),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'images/hotdog.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: onStart,
            child: const Text(
              '',
              style: TextStyle(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
