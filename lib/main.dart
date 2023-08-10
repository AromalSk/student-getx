import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/screen/home/home_screen.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  //  StudentController myController = Get.put(StudentController());
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // myController.getallStudents();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(  
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}


