import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:infinite_photo_tape/page/main_page.dart';
import 'package:infinite_photo_tape/service/photo_service.dart';

import 'domain/photo.dart';

void main() async{
  await init();
  //var box = await Hive.openBox<Photo>('photos');
  //await box.clear();
  runApp(const MyApp());
}

init() async {
  await initDatabase();
  initDependencies();
}

Future<void> initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());
}

void initDependencies() {
  GetIt.I.registerSingleton<PhotoService>(PhotoService());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
