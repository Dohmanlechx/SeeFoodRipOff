import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:see_food/not_hotdog.dart';

class NotHotdogScreen extends StatefulWidget {
  final Uint8List image;
  final VoidCallback onStart;

  const NotHotdogScreen({
    super.key,
    required this.image,
    required this.onStart,
  });

  @override
  State<NotHotdogScreen> createState() => _NotHotdogScreenState();
}

class _NotHotdogScreenState extends State<NotHotdogScreen> {
  final Flutter3DController hotdogController = Flutter3DController();

  var _showHotdog = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        _showHotdog = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.memory(widget.image, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/not_hotdog.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: NotHotdog(
            hotdogController,
            startAnimation: _showHotdog,
          ),
        ),
        Positioned.fill(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: widget.onStart,
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
