import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanner_app/globals/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scanner_app/regex/regex.dart';
void readHistory(){
  for(int i =objectStrings.length-1; i>-1;i--){
    if(objectStrings[i].substring(0,1) == 'u'){
      historyObjects.add(UrlLink(objectStrings[i].substring(1)));
    }else if(objectStrings[i].substring(0,1) == 'p'){
      historyObjects.add(PhoneNumber(objectStrings[i].substring(1)));
    }
  }
}

void saveHistory(dynamic obj) {
  historyObjects.insert(0, obj);
  if(obj.runtimeType == UrlLink){
    objectStrings.add('u' + obj.url);
  }else if(obj.runtimeType == PhoneNumber){
    objectStrings.add('p' + obj.phoneNumber);
  }
  history.setStringList('objectStrings', objectStrings);
}
void updateHistory(){
  history.setStringList('objectStrings', objectStrings);
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void cameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    firstCamera = cameras.first;
    history  = await SharedPreferences.getInstance();
    try {
      objectStrings = history.getStringList('objectStrings')!;
    }catch(e){
      history.setStringList('objectStrings', []);
    }
    readHistory();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    cameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: const Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 50.0,
          )
      ),
    );
  }
}
