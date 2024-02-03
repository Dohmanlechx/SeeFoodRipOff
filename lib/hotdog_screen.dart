import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:see_food/hotdog.dart';

class HotdogScreen extends StatefulWidget {
  final VoidCallback onStart;
  final Uint8List image;

  const HotdogScreen({
    super.key,
    required this.onStart,
    required this.image,
  });

  @override
  State<HotdogScreen> createState() => _HotdogScreenState();
}

class _HotdogScreenState extends State<HotdogScreen>
    with SingleTickerProviderStateMixin {
  final Flutter3DController hotdogController = Flutter3DController();

  late final AnimationController _translateController;
  late final Animation<double> _translateAnimation;
  var _showHotdog = false;

  @override
  void initState() {
    super.initState();

    _translateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _translateAnimation = Tween<double>(
      begin: 30.0,
      end: 0,
    ).animate(CurvedAnimation(
        parent: _translateController, curve: Curves.easeOutBack));

    _translateController.addListener(() {
      setState(() {
        hotdogController.setCameraTarget(0.0, _translateAnimation.value, 0.0);
      });
    });

    Future.microtask(() {
      _translateController.forward();
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
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/hotdog.png',
            fit: BoxFit.cover,
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
        Hotdog(
          hotdogController,
          startAnimation: _showHotdog,
        ),
      ],
    );
  }
}
