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
import 'dart:io' show Platform;

import 'package:see_food/object_detection.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  SeeFood(),
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
    if(hotDog == null) return "";
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: (image != null) ? Image.memory(image!) : const SizedBox.shrink(),
              ),
            ),
            Text(buildHotDogString(), style: const TextStyle(fontSize: 40)),
            
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

                        if (result == null) return ;
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
