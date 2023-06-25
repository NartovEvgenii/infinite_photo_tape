import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/photo.dart';
import '../page/photo_page.dart';
import '../service/photo_service.dart';
import 'favorite_icon_widget.dart';

typedef GetOffsetMethod = double Function();
typedef SetOffsetMethod = void Function(double offset);

class ListPhotos extends StatefulWidget {

  ListPhotos(this._photo, {super.key});

  final List<Photo> _photo;

  @override
  _ListPhotosState createState() => _ListPhotosState(_photo);
}

class _ListPhotosState extends State<ListPhotos> {

  _ListPhotosState(this._photo);

  final _photoService = GetIt.I.get<PhotoService>();
  List<Photo> _photo;
  late ScrollController scrollController;
  late double listPhotoOffset = 0.0;

  StreamController<double> _controller = new StreamController<double>.broadcast();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
        initialScrollOffset: listPhotoOffset
    );
    EasyDebounce.debounce(
        'my-debouncer',                 // <-- An ID for this particular debouncer
        Duration(milliseconds: 500),    // <-- The debounce duration
            () => _controller.stream.listen((value) {
          _saveState(value);
        })                // <-- The target method
    );

    _restoreState().then((double value) => scrollController.jumpTo(value));
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        child: ListView.builder(
          controller: scrollController,
          itemCount: _photo.length + 1,
          itemBuilder: (context, index) {
            if (index >= _photo.length) {
              fetchData();
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
            }
            final Photo photo = _photo[index];
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(photo.title,
                          style: const TextStyle(color: Colors.black,
                              fontSize: 30.0)),
                      InkWell(
                        onTap:() => goToImagePage(index, photo),
                        child: Image.network(photo.urlPhoto),
                      ),
                      FavoriteIcon(index, _photoService, photo.like)
                    ]
                )
            );
          },
        ),
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            _setOffset(notification.metrics.pixels);
          }
          return true;
        }
    );
  }

  void _saveState(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('listViewOffset', value);
  }

  Future<double> _restoreState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('listViewOffset')!;
  }

  void _setOffset(double offset) {
    listPhotoOffset = offset;
    _controller.add(offset);
  }


  Future<Future<Object?>> goToImagePage(int index, Photo photo) async {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  PhotoPage(photo,index),
    ));
  }


  Future<void> fetchData() async {
    _photoService.generatePhotos().then((value) => setState(() {}));
  }
}