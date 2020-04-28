import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/action_buttons.dart';
import '../widgets/http_request_loading.dart';
import '../http/file_upload.dart';

import '../http/http_configs.dart';
import '../picker.dart';
import '../http/http_wrapper.dart';

typedef Future<ApiResult> FileUploadHandler(String path);

///Features:
///1. 支持单张图片和多张图片
///2. 单张图片时可以指定宽高
///3. 多张图片时可以指定单行最多显示的图片数, 最大高度.
///4. 支持图片上传.
///5. 支持删除图片.
///6. 支持默认显示的图片.
///7. 无图片时显示提示上传的按钮,文本或图标
class PhotoWidget extends StatefulWidget {
  final FileUploadBean photo;
  final double width;
  final double height;
  final BoxFit fit;
  final String placeholder;
  final bool editable;
  final FileUploadHandler fileUploadHandler;

  const PhotoWidget({
    Key key,
    this.photo,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder = "ico_no_data.png",
    this.editable = false,
    this.fileUploadHandler,
  })  : assert(placeholder != null),
        super(key: key);

  @override
  PhotoWidgetState createState() => PhotoWidgetState();
}

class PhotoWidgetState extends State<PhotoWidget> {
  FileUploadBean get photo => _newPhoto ?? widget.photo;

  UploadFileStatus get status => _statusNotifier.value;

  ValueNotifier<UploadFileStatus> _statusNotifier;
  String _pickedImagePath;
  FileUploadBean _newPhoto;

  @override
  void initState() {
    _statusNotifier = ValueNotifier(UploadFileStatus.none);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = Configs.of(context);
    return ValueListenableBuilder(
      valueListenable: _statusNotifier,
      builder: (BuildContext context, UploadFileStatus status, Widget child) {
        Widget contentWidget;
        switch (status) {
          case UploadFileStatus.uploading:
            contentWidget = SizedBox(
              width: widget.width,
              height: widget.height,
              child: LoadingIndicator(),
            );
            break;
          case UploadFileStatus.failed:
            contentWidget = SizedBox(
              child: _buildFailedWidget(),
              width: widget.width,
              height: widget.height,
            );
            break;
          default:
            contentWidget = Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                _buildImageLayer(config.imageRoot),
                if (widget.editable ?? false)
                  if (photo?.isEmpty ?? true)
                    _buildUploadImageLayer()
                  else ...[
                    _buildUpdateButtonLayer(),
                    _buildDeleteButtonLayer(),
                  ]
              ],
            );
        }
        return contentWidget;
      },
    );
  }

  Widget _buildFailedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("上传失败!"),
        SizedBox(height: 8),
        SizedBox(
          height: 28,
          child: RaisedButton(
            padding: EdgeInsets.zero,
            child: Text("重试"),
            onPressed: () {
              _startUpload(_pickedImagePath);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButtonLayer() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: SizedBox(
        height: 28,
        child: RaisedButton(
          child: Text("重新上传"),
          color: Colors.black.withOpacity(0.6),
          padding: EdgeInsets.zero,
          onPressed: _uploadImage,
        ),
      ),
    );
  }

  Widget _buildDeleteButtonLayer() {
    return Positioned(
      right: 0,
      top: 0,
      child: ClearButton(
        onPressed: () {
          photo?.clear();
          _statusNotifier.value = UploadFileStatus.none;
        },
      ),
    );
  }

  Widget _buildImageLayer(String imageRoot) {
    if (photo?.hasLocalCache ?? false)
      return InkWell(
        child: Image.file(
          File(photo.localPath),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        ),
        onTap: () {
          Picker.of(context).previewPhoto(context, photo);
        },
      );
    else if (photo?.hasUrl ?? false)
      return InkWell(
        child: FadeInImage.assetNetwork(
          placeholder: "$imageRoot/${widget.placeholder}",
          image: photo.url,
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
        ),
        onTap: () {
          Picker.of(context).previewPhoto(context, photo);
        },
      );
    else
      return Image.asset(
        "$imageRoot/${widget.placeholder}",
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
      );
  }

  Widget _buildUploadImageLayer() {
    return Positioned.fill(
      child: Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.add),
            onPressed: _uploadImage,
          ),
        ),
      ),
    );
  }

  void _uploadImage() {
    Picker.of(context).pickImage(context).then((imagePath) {
      if (imagePath != null) {
        _pickedImagePath = imagePath;
        photo?.clear();
        if (widget.fileUploadHandler != null) {
          _startUpload(imagePath);
        }
      }
    });
  }

  void _startUpload(String imagePath) {
    _statusNotifier.value = UploadFileStatus.uploading;
    widget.fileUploadHandler(imagePath)?.then((result) {
      if (mounted) {
        if (result.success()) {
          _newPhoto = result.data;
          _statusNotifier.value = UploadFileStatus.success;
        } else {
          _statusNotifier.value = UploadFileStatus.failed;
        }
      }
    });
  }
}

enum UploadFileStatus { none, uploading, failed, success }

class MultiPhotoWidget extends StatefulWidget {
  @override
  _MultiPhotoWidgetState createState() => _MultiPhotoWidgetState();
}

class _MultiPhotoWidgetState extends State<MultiPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
