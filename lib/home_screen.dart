import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:see_food/hotdog.dart';
import 'package:see_food/text_outline.dart';

class HomeScreen extends StatefulWidget {
  final bool started;
  final VoidCallback onStart;
  final Future<void> Function() onPhoto;

  const HomeScreen({
    super.key,
    required this.started,
    required this.onStart,
    required this.onPhoto,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final Flutter3DController hotdogController = Flutter3DController();

  late final AnimationController _translateController;
  late final Animation<double> _translateAnimation;
  var _showHotdog = false;

  @override
  void initState() {
    super.initState();

    _translateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _translateAnimation = Tween<double>(
      begin: 20,
      end: 0,
    ).animate(CurvedAnimation(
        parent: _translateController, curve: Curves.easeOutBack));

    _translateController.addListener(() {
      setState(() {
        hotdogController.setCameraTarget(0.0, _translateAnimation.value, 0.0);
      });
    });

    Future.delayed(const Duration(seconds: 1)).then((value) {
      _showHotdog = true;
      _translateController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: const TextOutline(
                text: 'SEEFOOD',
                textColor: Colors.white,
                fontSize: 96.0,
                outlineColor: Colors.black,
                outlineThickness: 4,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TextOutline(
                text: '“The Shazam for Food”',
                textColor: Colors.red,
                fontSize: 32.0,
                outlineColor: Colors.black.withOpacity(0.5),
                outlineThickness: 1,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home-background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (!widget.started)
                    Container(
                      color: Colors.black
                          .withOpacity(0.5), // Adjust opacity as needed
                    ),
                  if (!widget.started)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 64.0,
                      ),
                      child: const TextOutline(
                        text: 'Let’s Get Started',
                        textColor: Colors.white,
                        fontSize: 32.0,
                        outlineColor: Colors.black,
                        outlineThickness: 1.5,
                      ),
                    ),
                  if (widget.started)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.75),
                            Colors.transparent
                          ],
                        ),
                      ),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: widget.onPhoto,
                                child: Image.asset(
                                  'assets/images/button.png',
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 16.0,
                                ),
                                child: const TextOutline(
                                  text: 'Touch to SEEFOOD',
                                  textColor: Colors.white,
                                  fontSize: 32.0,
                                  outlineColor: Colors.black,
                                  outlineThickness: 1.5,
                                ),
                              ),
                            ],
                          )),
                    ),
                ],
              ),
            ),
          ],
        ),
        // Opacity is a hack, as it seems like we can't set an initial camera position
        Opacity(
          opacity: _showHotdog ? 1 : 0,
          child: Hotdog(
            hotdogController,
            startAnimation: _showHotdog,
          ),
        ),
        if (!widget.started)
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
