import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercommon/src/http/file_upload.dart';
import 'package:photo_view/photo_view.dart';

import '../ui.dart';

class ConfirmPickedPhotoPage extends StatelessWidget {
  final FileUploadBean photo;

  const ConfirmPickedPhotoPage({
    Key key,
    @required this.photo,
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
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 16),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey,
                        shape: StadiumBorder(),
                        child: Text(
                          "重新选择",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Ui.btnBgColor,
                        child: Text(
                          "确定",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(photo.localPath);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
