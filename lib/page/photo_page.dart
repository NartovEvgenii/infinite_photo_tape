
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/photo.dart';
import '../service/photo_service.dart';
import '../widget/favorite_icon_widget.dart';
import 'main_page.dart';

class PhotoPage extends  StatelessWidget {
  PhotoPage(this.photo, this.index,{super.key});

  final _photoService = GetIt.I.get<PhotoService>();
  final Photo photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                fit: BoxFit.fitWidth,
                height: double.infinity,
                width: double.infinity,
                image: NetworkImage(photo.urlPhoto),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 70,
                    color: Colors.grey,
                    icon: const Icon(Icons.clear),
                    onPressed: () => goToMainPage(context),
                  ),
                  FavoriteIcon(index, _photoService, photo.like, size: 60)
                ],
              )
            ]
        )
    );
  }

  Future<Future<Object?>> goToMainPage(context) async {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  MainPage(),
    ));
  }


}


