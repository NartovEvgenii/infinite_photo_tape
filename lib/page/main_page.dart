import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/photo.dart';
import '../service/photo_service.dart';
import '../widget/list_photo_widget.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final _photoService = GetIt.I.get<PhotoService>();

  late List<Photo> _photo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:FutureBuilder<List<Photo>>(
          future: _photoService.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _photo = snapshot.data!;
              return ListPhotos(_photo);
            } else {
              return CircularProgressIndicator();
            }
        },
      )
    );
  }



}