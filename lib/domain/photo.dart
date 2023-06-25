import 'package:hive/hive.dart';

part 'photo.g.dart';

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  final String urlPhoto;
  @HiveField(1)
  final String title;
  @HiveField(2)
  bool like;

  Photo({required this.urlPhoto, required this.title, required this.like});


}