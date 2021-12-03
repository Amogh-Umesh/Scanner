import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:scanner_app/globals/globals.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/services.dart';
import 'package:scanner_app/classes/url_phone.dart';
import 'package:scanner_app/regex/regex.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return TakePictureScreen(
      camera: firstCamera,
    );
  }
}


class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _controller.setFlashMode(FlashMode.off);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String urL = '';
  List<Widget> display = [];
  void getDisplay() {
    if (scannedObjects.isNotEmpty) {
      display = [
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction){
            setState(() {
              scannedObjects.removeAt(0);
              getDisplay();
            });
          },
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: UrlPhone(obj: scannedObjects[0])),
        ),
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.08,
        ),
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera'),
      centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CameraPreview(_controller,
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child:Container(
                        margin: const EdgeInsets.all(10),
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          tooltip: 'Capture',
                          elevation: 20,
                          highlightElevation: 40,
                          focusElevation: 40,
                          onPressed: () async {
                            try {
                              // Ensure that the camera is initialized.
                              await _initializeControllerFuture;
                              final image = await _controller.takePicture();
                              File cameraImage = File(image.path);

                              final inputImage = InputImage.fromFile(cameraImage);
                              final textDetector = GoogleMlKit.vision.textDetector();
                              final RecognisedText recognisedText = await textDetector.processImage(inputImage);
                              late String scannedText = '';
                              for (TextBlock block in recognisedText.blocks) {
                                for (TextLine line in block.lines) {
                                  for (TextElement element in line.elements) {
                                    scannedText += element.text;
                                  }
                                  scannedText += ' ';
                                }
                                scannedText += '\n';
                              }
                              setState(() {
                                scannedObjects = getScannedData(scannedText);
                                getDisplay();
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Icon(Icons.circle),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: display,
          ),


        ]
      ),

    );
  }
}
