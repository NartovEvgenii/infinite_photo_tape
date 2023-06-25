import 'package:hive/hive.dart';

import '../domain/photo.dart';

abstract class AbstractPhotoRepository {
  Future<List<Photo>> getPhotos();

  Future<void> addPhoto(Photo photo);

}

class PhotoRepository extends AbstractPhotoRepository {
  @override
  Future<List<Photo>> getPhotos() async {
    var box = await Hive.openBox<Photo>('photos');
    return List.of(box.values);
  }

  @override
  Future<void> addPhoto(Photo photo) async {
    var box = await Hive.openBox<Photo>('photos');
    await  box.add(photo);
  }

  @override
  Future<Photo?> getPhoto(int index) async {
    var box = await Hive.openBox<Photo>('photos');
     return box.getAt(index);
  }

  @override
  Future<void> updatePhoto(int index, Photo photo) async {
    var box = await Hive.openBox<Photo>('photos');
    box.putAt(index, photo);
  }

}