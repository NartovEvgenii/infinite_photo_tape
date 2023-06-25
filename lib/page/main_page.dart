import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/photo.dart';
import '../service/photo_service.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final _photoService = GetIt.I.get<PhotoService>();

  late List<Photo> _photo = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        fetchData();
      }
    });
    return Scaffold(
        body:FutureBuilder<List<Photo>>(
          future: _photoService.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _photo = snapshot.data!;
              return ListView.builder(
                  controller: _scrollController,
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
                          fontSize: 20.0)),
                        Image(
                          image: NetworkImage(photo.urlPhoto),
                        ),
                        Icon(Icons.favorite_border, size: 30)
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


  Future<void> fetchData() async {
    _photoService.generatePhotos().then((value) => setState(() {}));
  }


}