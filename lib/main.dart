import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_detection_ssd_mobilenet/home_screen.dart';
import 'package:object_detection_ssd_mobilenet/evaluating_screen.dart';
import 'package:object_detection_ssd_mobilenet/hotdog_screen.dart';
import 'package:object_detection_ssd_mobilenet/not_hotdog_screen.dart';
import 'package:object_detection_ssd_mobilenet/object_detection.dart';

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

enum ScreenName { home, evaluating, result }

class _MyHomeState extends State<MyHome> {
  final imagePicker = ImagePicker();

  ScreenName screen = ScreenName.home;
  bool homeStarted = false;
  ObjectDetection? objectDetection;
  late Uint8List image;
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
      }
      else {
        homeStarted = true;
      }
    });
  }

  Future<void> handlePhoto() async {
    final result = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (result == null) return;
    final imageBytes = await result.readAsBytes();
    setState(() {
      image  = Uint8List.fromList(imageBytes);
      screen = ScreenName.evaluating;
    });
    await Future.delayed(const Duration(seconds: 7));
    final data = objectDetection!.analyseImage(result.path);
    setState(() {
      hotDog = data.isHotDog;
      screen = ScreenName.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (screen == ScreenName.home) {
      return Scaffold(
        body: SafeArea(
          child: HomeScreen(
            started: homeStarted,
            onStart: handleStartToggle,
            onPhoto: handlePhoto,
          ),
        ),
      );
    }
    if (screen == ScreenName.evaluating) {
      return Scaffold(
        body: SafeArea(
          child: EvaluatingScreen(
            image: image,
          ),
        ),
      );
    }
    if (screen == ScreenName.result) {
      if (hotDog == true) {
        return Scaffold(
          body: SafeArea(
            child: HotdogScreen(
              image: image,
              onStart: handleStartToggle,
            ),
          ),
        );
      }
      return Scaffold(
        body: SafeArea(
          child: NotHotdogScreen(
            image: image,
            onStart: handleStartToggle,
          ),
        ),
      );
    }
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}



