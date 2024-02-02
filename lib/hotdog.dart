import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Hotdog extends StatefulWidget {
  const Hotdog({super.key});

  @override
  State<Hotdog> createState() => _HotdogState();
}

class _HotdogState extends State<Hotdog> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  var value = 0.0;
  final speed = 2.0;

  final Flutter3DController hotdogController = Flutter3DController();

  @override
  void initState() {
    super.initState();

    ticker = createTicker((_) {
      setState(() {
        hotdogController.setCameraOrbit(
          value += speed,
          60,
          120,
        );
      });
    })
      ..start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const path = 'assets/models/hotdog.glb';

    return Flutter3DViewer(
      src: path,
      controller: hotdogController,
    );
  }
}
