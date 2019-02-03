import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPicture extends StatelessWidget {

  static const tag = 'post_image';
  final String imageUrl;

  const FullScreenPicture({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        maxScale: PhotoViewComputedScale.contained * 2,
        minScale: PhotoViewComputedScale.contained,
        heroTag: tag,
      ),
    );
  }
}
