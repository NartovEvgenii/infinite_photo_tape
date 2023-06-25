import 'dart:convert';
import 'dart:math';

import 'package:uuid/uuid.dart';

import '../domain/photo.dart';
import 'package:http/http.dart' as http;

import '../repository/photo_repository.dart';

class PhotoService {

  PhotoRepository repository = PhotoRepository();
  var uuid = const Uuid();

  static const apiKey= String.fromEnvironment('API_KEY', defaultValue: "default");
  static const baseUrl= String.fromEnvironment('BASE_URL', defaultValue: "default");

  Future<Photo?> generatePhotos() async{
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
      var idPhoto = uuid.v1();
      Photo photo = Photo(idPhoto: idPhoto,
                          urlPhoto: '${imageUrl}',
                          title: 'Photo ${idPhoto}',
                          like: false);
      repository.addPhoto(photo);
      return photo;
    }
    return null;

  }

  Future<void> updateLikePhoto(int index) async{
    Photo? photo = await repository.getPhoto(index);
    photo?.like = !photo.like;
    repository.updatePhoto(index, photo!);
  }

  Future<List<Photo>> getPhotos() {
    return repository.getPhotos();
  }
}