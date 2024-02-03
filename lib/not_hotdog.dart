import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class NotHotdog extends StatefulWidget {
  const NotHotdog(this.controller, {required this.startAnimation, super.key});

  final Flutter3DController controller;
  final bool startAnimation;

  @override
  State<NotHotdog> createState() => _HotdogState();
}

class _HotdogState extends State<NotHotdog> with TickerProviderStateMixin {
  late final Ticker ticker;

  var value = 0.0;
  var speed = 3.0;

  @override
  void didUpdateWidget(covariant NotHotdog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.startAnimation && widget.startAnimation) {
      ticker = createTicker((_) {
        widget.controller.setCameraOrbit(
          value += speed,
          60,
          200,
        );
      })
        ..start();
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

    return Stack(
      children: [
        Flutter3DViewer(
          src: path,
          controller: widget.controller,
        ),
        const RedCrossWidget(),
      ],
    );
  }
}

class RedCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the border
    final borderPaint = Paint()
      ..color = Colors.black // Set the paint color to black for the border
      ..strokeWidth = 30 // Set the stroke width larger for the border
      ..style = PaintingStyle.stroke; // Use stroke style

    // Paint for the cross
    final crossPaint = Paint()
      ..color = Colors.red // Set the paint color to red for the cross
      ..strokeWidth = 15 // Set the stroke width smaller than the border's width
      ..style = PaintingStyle.stroke; // Use stroke style

    // Calculate the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Define the size of the cross
    final crossSize = size.width < size.height ? size.width : size.height;

    // Draw the vertical line of the border
    canvas.drawLine(
      Offset(centerX, centerY - crossSize / 2),
      Offset(centerX, centerY + crossSize / 2),
      borderPaint,
    );

    // Draw the horizontal line of the border
    canvas.drawLine(
      Offset(centerX - crossSize / 2, centerY),
      Offset(centerX + crossSize / 2, centerY),
      borderPaint,
    );

    // Draw the vertical line of the cross
    canvas.drawLine(
      Offset(centerX,
          centerY - (crossSize / 2 - 2)), // Slightly shorter for visual border
      Offset(
          centerX,
          centerY +
              (crossSize / 2 - 2)), // Adjust -2/+2 to ensure border visibility
      crossPaint,
    );

    // Draw the horizontal line of the cross
    canvas.drawLine(
      Offset(centerX - (crossSize / 2 - 2),
          centerY), // Slightly shorter for visual border
      Offset(centerX + (crossSize / 2 - 2),
          centerY), // Adjust -2/+2 to ensure border visibility
      crossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Use the custom painter in a widget
class RedCrossWidget extends StatefulWidget {
  const RedCrossWidget({super.key});

  @override
  State<RedCrossWidget> createState() => _RedCrossWidgetState();
}

class _RedCrossWidgetState extends State<RedCrossWidget> {
  late final Timer timer;
  var visible = true;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (mounted) {
        setState(() {
          visible = !visible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: visible ? 1 : 0,
      child: Transform.rotate(
        angle: pi / 4,
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity), // The canvas size
          painter: RedCrossPainter(),
        ),
      ),
    );
  }
}
