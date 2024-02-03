/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:see_food/evaluating_screen.dart';
import 'package:see_food/home_screen.dart';
import 'package:see_food/hotdog_screen.dart';
import 'package:see_food/not_hotdog_screen.dart';
import 'package:see_food/object_detection.dart';

const skipCameraForTesting = false;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeeFoodApp',
      theme: ThemeData(fontFamily: 'Arial'),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

enum ScreenName { home, evaluating, result, octopus }

class _MyHomeState extends State<MyHome> {
  final imagePicker = ImagePicker();

  ObjectDetection? objectDetection;
  ScreenName screen = ScreenName.home;
  late Uint8List image;
  bool homeStarted = false;
  bool hotDog = false;

  @override
  void initState() {
    super.initState();
    objectDetection = ObjectDetection();
  }

  void handleStartToggle() {
    setState(() {
      if (homeStarted == true) {
        homeStarted = false;
        image = Uint8List.fromList([]);
        hotDog = false;
        screen = ScreenName.home;
      } else {
        homeStarted = true;
      }
    });
  }

  Future<void> handlePhoto() async {
    if (skipCameraForTesting) {
      image = Uint8List.fromList([]);
      setResult(true);
      return;
    }

    final result = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (result == null) return;
    final imageBytes = await result.readAsBytes();

    setState(() {
      image = Uint8List.fromList(imageBytes);
      screen = ScreenName.evaluating;
    });

    await Future.delayed(const Duration(seconds: 2));
    final data = objectDetection!.analyseImage(result.path);

    setResult(data.isHotDog);
  }

  void setResult(bool isHotDog) {
    setState(() {
      hotDog = isHotDog;
      screen = ScreenName.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hotDog ? Colors.green : Colors.red,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (screen == ScreenName.home) {
              return HomeScreen(
                started: homeStarted,
                onStart: handleStartToggle,
                onPhoto: handlePhoto,
              );
            }
            if (screen == ScreenName.evaluating) {
              return EvaluatingScreen(
                image: image,
              );
            }
            if (screen == ScreenName.result) {
              if (hotDog == true) {
                return HotdogScreen(
                  image: image,
                  onStart: handleStartToggle,
                );
              }
              return NotHotdogScreen(
                image: image,
                onStart: handleStartToggle,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
