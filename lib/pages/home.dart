import 'package:flutter/material.dart';
import 'package:scanner_app/globals/globals.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String scannedText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scanner',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 80,
              child: FloatingActionButton(
                  elevation: 10,
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    final cameras = await availableCameras();
                    firstCamera = cameras.first;
                    await Navigator.pushNamed(context, '/camera');
                  }),
            ),
          ]),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(scannedText),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
