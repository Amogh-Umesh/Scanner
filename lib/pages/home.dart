import 'package:flutter/material.dart';
import 'package:scanner_app/classes/url_phone.dart';
import 'package:scanner_app/globals/globals.dart';
import 'package:camera/camera.dart';
import 'package:scanner_app/pages/loading.dart';

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
        backgroundColor: Colors.green[500],
      ),
      body: SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 80,
              child: FloatingActionButton(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green[500],
                  elevation: 10,
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    final cameras = await availableCameras();
                    firstCamera = cameras.first;
                    await Navigator.pushNamed(context, '/camera').then((value) => setState(() {

                    }));

                  }),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                child: TextButton(
                    onPressed: () {},
                    child: const Text('History')),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        history.setStringList('objectStrings', []);
                        historyObjects = [];
                        objectStrings = [];
                      });
                    },
                    child: const Text('Clear')),
              )
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          Expanded(

            child: ListView.separated(

              scrollDirection: Axis.vertical,
              itemCount: historyObjects.length,
              itemBuilder: (context, index) {
                return Dismissible(key: UniqueKey(),onDismissed: (direction){setState(() {
                  historyObjects.removeAt(index);
                  objectStrings.removeLast();
                  updateHistory();
                });},child: ListTile(title: UrlPhone(obj: historyObjects[index])));
              },
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                thickness: 1,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
