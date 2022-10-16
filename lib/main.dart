import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nawgati_calc/controller/notifier.dart';
import 'package:hive/hive.dart';
import 'package:nawgati_calc/models/provider_models/history.dart';
import 'package:nawgati_calc/utils/consts.dart';
import 'package:provider/provider.dart';

import 'UI/calchomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Yaha pe using hive_flutter package to take care of 
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
    return ChangeNotifierProvider(
      create: (context) => CalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nawgati CalC',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          accentColor: blueSplash,
          textTheme: TextTheme(
            headline3: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            caption: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
              fontSize: 18.0,
            ),
          ),
        ),
        routes: {
          '/' : (context) => HomePage()
        },
      ),
    );
  }
}
