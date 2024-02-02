import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Hotdog extends StatefulWidget {
  const Hotdog(this.controller, {super.key});

  final Flutter3DController controller;

  @override
  State<Hotdog> createState() => _HotdogState();
}

class _HotdogState extends State<Hotdog> with TickerProviderStateMixin {
  late final Ticker ticker;

  var value = 0.0;
  var speed = 20.0;

  var init = true;

  @override
  void initState() {
    super.initState();

    ticker = createTicker((_) {
      widget.controller.setCameraOrbit(
        value += speed,
        60,
        200,
      );
    })
      ..start();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      speed = 6.0;
    });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      speed = 2.0;
    });
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const path = 'assets/models/hotdog4.glb';

    return Flutter3DViewer(
      src: path,
      controller: widget.controller,
    );
  }
}
