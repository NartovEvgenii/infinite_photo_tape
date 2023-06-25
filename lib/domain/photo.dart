import 'package:hive/hive.dart';

part 'photo.g.dart';

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  final String idPhoto;
  @HiveField(1)
  final String urlPhoto;
  @HiveField(2)
  final String title;
  @HiveField(3)
  bool like;

  Photo({required this.idPhoto, required this.urlPhoto, required this.title, required this.like});


}