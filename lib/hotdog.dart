import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Hotdog extends StatefulWidget {
  const Hotdog(this.controller, {required this.startAnimation, super.key});

  final Flutter3DController controller;
  final bool startAnimation;

  @override
  State<Hotdog> createState() => _HotdogState();
}

class _HotdogState extends State<Hotdog> with TickerProviderStateMixin {
  late final AnimationController _translateController;
  late final Animation<double> _translateAnimation;

  late final Ticker ticker;
  Ticker? ticker2;

  var value = 0.0;
  static const maxSpeed = 20.0;
  static const minSpeed = 3.0;
  var speed = maxSpeed;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Hotdog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.startAnimation && widget.startAnimation) {
      _translateController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      );

      _translateAnimation = Tween<double>(
        begin: 500.0,
        end: 0,
      ).animate(
          CurvedAnimation(parent: _translateController, curve: Curves.linear));

      ticker = createTicker((_) {
        widget.controller.setCameraOrbit(
          value += speed,
          60,
          200,
        );
      })
        ..start();

      ticker2 = Ticker((elapsed) {
        final percentage = (elapsed.inMilliseconds / 2000) * 100;

        const diff = maxSpeed - minSpeed;
        speed = maxSpeed - (diff * (percentage / 100));

        if (percentage > 100) {
          ticker2!.stop();
          speed = minSpeed;
        }
      })
        ..start();

      _translateController.forward();
    }
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const path = 'assets/models/hotdog.glb';

    // Opacity is a hack, as it seems like we can't set an initial camera position
    return AnimatedBuilder(
      animation: _translateAnimation,
      builder: (_, __) {
        print(_translateAnimation.value);
        return Transform.translate(
          offset: Offset(0, _translateAnimation.value),
          child: Opacity(
            opacity: 1, // widget.startAnimation ? 1 : 0,
            child: Flutter3DViewer(
              src: path,
              controller: widget.controller,
            ),
          ),
        );
      },
    );
  }
}
