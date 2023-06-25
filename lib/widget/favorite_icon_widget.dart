import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  FavoriteIcon(this.index,this._photoService, this.isFavorited, {super.key, this.size});

  final int index;
  final _photoService;
  final bool isFavorited;
  double? size;

  @override
  State<StatefulWidget> createState() {
    return _FavoriteIconState(index, _photoService, isFavorited, size: size);
  }
}

class _FavoriteIconState extends State<FavoriteIcon> {
  final int index;
  final _photoService;
  bool isFavorited;
  double? size;

  _FavoriteIconState(this.index, this._photoService, this.isFavorited, {this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size ?? 40,
      icon: const Icon(Icons.favorite),
      color: isFavorited ? Colors.pink : Colors.grey,
      onPressed: () => _onFavoriteButtonClicked(),
    );
  }

  Future<void> _onFavoriteButtonClicked() async {
    isFavorited = !isFavorited;
    _photoService.updateLikePhoto(index).then((value) => setState(() {}));
  }

}