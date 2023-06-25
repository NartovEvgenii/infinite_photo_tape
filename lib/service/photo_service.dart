import 'dart:convert';
import 'dart:math';

import '../domain/photo.dart';
import 'package:http/http.dart' as http;

import '../repository/photo_repository.dart';

class PhotoService {

  List<Photo> photos = List.from(
      [Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                                      title: 'Photo 1', like: false),
      Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          title: 'Photo 2', like: false),
      Photo(urlPhoto: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      title: 'Photo 3', like: false)]);


  PhotoRepository repository = PhotoRepository();

  late int counter = 3;
  static const apiKey= String.fromEnvironment('API_KEY', defaultValue: "default");
  static const baseUrl= String.fromEnvironment('BASE_URL', defaultValue: "default");

  Future<bool> generatePhotos() async{
    final url = Uri.https('${baseUrl}','/services/rest/',
                                  {
                                    'method': 'flickr.galleries.getPhotos',
                                    'api_key': '${apiKey}',
                                    'gallery_id': '66911286-72157647277042064',
                                    'format': 'json',
                                    'nojsoncallback': '1',
                                  }
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var parsedPizzaJsonArray = const JsonDecoder().convert(response.body);
      int pageNum = Random().nextInt(parsedPizzaJsonArray['photos']['total']);
      var jsonPhoto = parsedPizzaJsonArray['photos']['photo'][pageNum];
      var farmId = jsonPhoto['farm'];
      var serverId = jsonPhoto['server'];
      var id = jsonPhoto['id'];
      var secret = jsonPhoto['secret'];
      var imageUrl = 'https://farm${farmId}.staticflickr.com/${serverId}/${id}_${secret}.jpg';
      Photo photo = Photo(urlPhoto: '${imageUrl}',
          title: 'Photo ${counter++}', like: false);
      repository.addPhoto(photo);
    }
    return true;
  }

  Future<List<Photo>> getPhotos() {
    return repository.getPhotos();
  }
}