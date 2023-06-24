import '../domain/photo.dart';

class PhotoService {

  List<Photo> photos = List.from(
      [Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                                      title: 'Photo 1'),
      Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          title: 'Photo 2'),
      Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      title: 'Photo 3')]);

  late int counter = 3;

  Photo generatePhotos() {
    counter++;
    Photo photo = Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        title: 'Photo ${counter}');
    photos.add(photo);
    return photo;
  }

  Future<List<Photo>> getPhotos() {
    return Future.value(photos);
  }
}