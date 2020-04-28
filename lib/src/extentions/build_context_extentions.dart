import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercommon/src/http/http_wrapper.dart';
import 'package:fluttercommon/src/widgets/http_request_loading.dart';

extension BuildContextExtentions on BuildContext {
  void showSnackBar(
    String message, {
    backgroundColor: Colors.amber,
    int seconds = 2,
  }) {
    var finalMessage = message;
    if (message != null && message.length > 100) {
      finalMessage = message.substring(0, 100);
    }
    Scaffold.of(this)?.showSnackBar(SnackBar(
      content: Text(finalMessage ?? ""),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: seconds),
    ));
  }

  Future<void> showAlert({
    String titleText = "提示",
    String actionLabel = "确定",
    String message,
    Widget content,
  }) {
    return showDialog(
        context: this,
        builder: (context) {
          return AlertDialog(
            title: Text(titleText),
            content: content ??
                Text(
                  message ?? "???",
                  style: Theme.of(context).textTheme.body1,
                ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  actionLabel,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  Future<bool> showConfirmDialog({
    String message,
    Widget content,
    String titleText = "提示",
    String confirmLabel = "确定",
    String cancelLabel = "取消",
    bool canCancel = true,
  }) {
    return showDialog(
        context: this,
        barrierDismissible: canCancel,
        builder: (context) {
          return AlertDialog(
            title: Text(titleText),
            content: content ?? Text(message ?? ""),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  cancelLabel,
                ),
              ),
              RaisedButton(
                child: Text(
                  confirmLabel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  Future<ApiResult> sendRequest(
    Future<ApiResult> request, {
    bool showErrorMessage = true,
    String loadingText = "请稍后...",
    Widget waitingWidget,
    bool enableBackKey = true,
  }) async {
    ApiResult apiResult;
    bool isShow = false;
    Future.delayed(Duration(milliseconds: 1), () {
      if (apiResult == null) {
        isShow = true;
        showDialog(
            context: this,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => enableBackKey,
                child: StreamBuilder<ApiResult>(
                  stream: Stream.periodic(Duration(milliseconds: 100), (count) {
                    return apiResult;
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    debugPrint('snapshot is ${snapshot.toString()}');
                    if (snapshot.hasData && snapshot.data != null) {
                      if (isShow) {
                        isShow = false;
                        Future.delayed(Duration.zero, () {
                          Navigator.of(context).pop();
                        });
                      }
                    }

                    return SimpleDialog(
                      backgroundColor: Colors.transparent,
                      children: <Widget>[
                        waitingWidget ?? LoadingWidget(loadingText: loadingText)
                      ],
                    );
                  },
                ),
              );
            });
      }
    });

    try {
      apiResult = await request;
    } catch (e) {
      apiResult = ApiResult.fakeResult(0, e.toString());
    }

    if (isShow) {
      isShow = false;
      Navigator.of(this).pop();
    }

    if (showErrorMessage == true && apiResult?.success() == false) {
      String message = apiResult.message();
      if (message.length > 100) {
        message = message.substring(0, 99);
      }
      await showAlert(message: message);
    }

    return apiResult;
  }

  Future<T> goto<T extends Object>(Widget page) {
    return Navigator.of(this)
        .push<T>(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  bool pop<T extends Object>([T result]) {
    return Navigator.of(this).pop(result);
  }
}
