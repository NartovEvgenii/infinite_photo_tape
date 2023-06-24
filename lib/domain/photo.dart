import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  final String urlPhoto;
  @HiveField(1)
  final String title;

  Photo({required this.urlPhoto, required this.title});


}