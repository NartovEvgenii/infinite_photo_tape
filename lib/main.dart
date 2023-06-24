import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_photo_tape/page/main_page.dart';
import 'package:infinite_photo_tape/service/photo_service.dart';

void main() {
  init();
  runApp(const MyApp());
}

init() async {
  initDependencies();
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
