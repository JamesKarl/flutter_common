import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercommon/src/http/file_upload.dart';
import 'package:photo_view/photo_view.dart';

import '../ui.dart';

class PhotoPreviewPage extends StatelessWidget {
  final FileUploadBean photo;
  final String heroTag;

  const PhotoPreviewPage({
    Key key,
    @required this.photo,
    this.heroTag,
  })  : assert(photo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          PhotoView(
            loadingChild: Ui.defaultLoading,
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            imageProvider: photo.hasLocalCache
                ? FileImage(File(photo.localPath))
                : NetworkImage(photo.url),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CircleAvatar(
                  radius: 24.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.maybePop(context, photo);
                    },
                  ),
                  backgroundColor: Ui.btnBgColor,
                ),
              )),
        ],
      ),
    );
  }
}
