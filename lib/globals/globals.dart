library my_prj.globals;
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';



late CameraDescription firstCamera;
List<String> objectStrings = [];
List<dynamic> scannedObjects = [];
late SharedPreferences history;
List<dynamic> historyObjects = [];
List<dynamic> temphistoryObjects = [];