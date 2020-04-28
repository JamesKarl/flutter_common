import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercommon/src/http/file_upload.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../ui.dart';
import 'confirm_picked_photo.dart';
import 'preview_photo.dart';

enum PickPhotoMode {
  galleryOnly,
  cameraOnly,
  ask,
}
mixin PhotoPicker {
  Future<FileUploadBean> previewPhoto(
      BuildContext context, FileUploadBean photo,
      {String heroTag}) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => PhotoPreviewPage(photo: photo, heroTag: heroTag)));
  }

  ///选择单张图片
  ///maxImages 最多选几张图片, 目前只支持单选
  ///pickPhotoMode 直接从图库中选, 直接拍照, 或用户自己选择
  ///cropRatio 裁剪宽高比. null时不裁剪.
  ///preview 图片选择完成后, 放大预览.
  Future<String> pickImage(
    BuildContext context, {
    //int maxImages = 1,
    PickPhotoMode pickPhotoMode = PickPhotoMode.ask,
    double cropRatio,
    bool preview = true,
  }) async {
    ImageSource imageSource;
    switch (pickPhotoMode) {
      case PickPhotoMode.galleryOnly:
        imageSource = ImageSource.gallery;
        break;
      case PickPhotoMode.cameraOnly:
        imageSource = ImageSource.camera;
        break;
      case PickPhotoMode.ask:
        imageSource = await _pickImageSource(context);
        break;
    }

    if (imageSource == null) {
      return null;
    }

    String imagePath;
    if (imageSource == ImageSource.gallery && (preview ?? false)) {
      do {
        final file = await _pickImage(imageSource);
        if (file == null) {
          return null;
        }
        final previewPath =
            await _confirmPickedImage(context, localPath: file.path);
        print("xxx previewPath = $previewPath");
        if (previewPath == null) {
          continue;
        }
        imagePath = file.path;
        break;
      } while (true);
    } else {
      final file = await _pickImage(imageSource);
      imagePath = file.path;
    }

    if (cropRatio != null && imagePath != null) {
      imagePath = await cropImage(imagePath, cropRatio: cropRatio);
    }

    return imagePath;
  }

  Future<File> _pickImage(ImageSource imageSource) {
    return ImagePicker.pickImage(
      source: imageSource,
      maxHeight: 2000,
      maxWidth: 2000,
      imageQuality: 50,
    );
  }

  ///从相册选择或拍照
  Future<ImageSource> _pickImageSource(BuildContext context) async {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text('选择图片来源'),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消')),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: Text('拍照')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: Text('相册')),
            ],
          );
        });
  }

  ///裁剪指定图片，返回裁剪后的图片路径或null
  Future<String> cropImage(String path, {double cropRatio = 1.0}) async {
    if (path == null || path.isEmpty || !File(path).existsSync()) return null;

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: CropAspectRatio(ratioX: cropRatio ?? 1.0, ratioY: 1.0),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: '裁剪图片',
          toolbarColor: Ui.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    return croppedFile?.path;
  }

  ///大图显示单张图片
  Future<String> _confirmPickedImage(
    BuildContext context, {
    String url,
    String localPath,
  }) {
    debugPrint("showBigImage url -> $url");
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ConfirmPickedPhotoPage(
          photo: FileUploadBean(url: url, localPath: localPath),
        ),
      ),
    );
  }
}
