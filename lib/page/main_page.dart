import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_photo_tape/page/photo_page.dart';

import '../domain/photo.dart';
import '../service/photo_service.dart';
import '../widget/favorite_icon_widget.dart';

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
              return ListView.builder(
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
              );
            } else {
              return CircularProgressIndicator();
            }
        },
      )
    );
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