import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nawgati_calc/models/provider_models/history.dart';

import 'UI/calchomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter(); // Yaha pe using hive_flutter package to take care of 
                      // providing the app directory and other details ....
  Hive.registerAdapter(HisModelAdapter());
  await Hive.openBox<HisModel>('history');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nawgati CalC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => HomePage()
      },
    );
  }
}
