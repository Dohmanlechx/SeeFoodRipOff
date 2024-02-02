import 'package:flutter/material.dart';
import 'package:see_food/text_outline.dart';

class HomeScreen extends StatelessWidget {
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
                  if (!started)
                    Container(
                      color: Colors.black
                          .withOpacity(0.5), // Adjust opacity as needed
                    ),
                  if (!started)
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
                  if (started)
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
                                onTap: onPhoto,
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
        if (!started)
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
