import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'UI/MusicListScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PermissionStatus permissionStatus = await Permission.storage.request();
  if(permissionStatus.isGranted){
    print('Storage permission granted');
  }else{
    openAppSettings();
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicListScreen(),
    );
  }
}

