import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;

import 'package:see_food/object_detection.dart';
import 'package:see_food/octopus_recipes.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SeeFood(),
    );
  }
}

class SeeFood extends StatefulWidget {
  const SeeFood({super.key});

  @override
  State<SeeFood> createState() => _SeeFoodState();
}

class _SeeFoodState extends State<SeeFood> {
  final imagePicker = ImagePicker();

  ObjectDetection? objectDetection;
  Uint8List? image;
  bool? hotDog;

  String buildHotDogString() {
    if (hotDog == null) return "";
    return hotDog == true ? "Hot Dog" : "Not Hot Dog";
  }

  @override
  void initState() {
    super.initState();
    objectDetection = ObjectDetection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.receipt),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OctopusRecipes(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: (image != null)
                    ? Image.memory(image!)
                    : const SizedBox.shrink(),
              ),
            ),
            Text(buildHotDogString(), style: const TextStyle(fontSize: 40)),

            // Add Lottie animation here
            Lottie.asset(
              'assets/lottie/spinner.json', // replace with your animation file
              width: 150,
              height: 150,
              repeat: true,
              reverse: false,
            ),

            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (Platform.isAndroid || Platform.isIOS)
                    IconButton(
                      onPressed: () async {
                        final result = await imagePicker.pickImage(
                          source: ImageSource.camera,
                        );

                        if (result == null) return;
                        final data = objectDetection!.analyseImage(result.path);

                        setState(() {
                          image = data.image;
                          hotDog = data.isHotDog;
                        });
                      },
                      icon: const Icon(
                        Icons.camera,
                        size: 64,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
