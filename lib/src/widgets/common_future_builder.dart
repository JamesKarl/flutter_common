import 'dart:async';

import 'package:flutter/material.dart';
import '../http/http_wrapper.dart';
import '../widgets/http_request_failed.dart';

import 'http_request_loading.dart';
import 'lazy_widget.dart';

typedef CommonFutureWidgetBuilder = Widget Function(
    BuildContext context, dynamic data);

class CommonFutureBuilder extends StatefulWidget {
  final Future<ApiResult> future;
  final CommonFutureWidgetBuilder builder;
  final Widget errorWidget;
  final Widget loadingWidget;

  const CommonFutureBuilder(
      {Key key,
      @required this.future,
      @required this.builder,
      this.errorWidget,
      this.loadingWidget})
      : assert(future != null),
        assert(builder != null),
        super(key: key);

  @override
  _CommonFutureBuilderState createState() => _CommonFutureBuilderState();
}

///loading 延迟多久显示
const _loadingDisplayedDelayedMilliseconds = 1500;
const _loadingDelayedTime =
    Duration(milliseconds: _loadingDisplayedDelayedMilliseconds);

///loading 最少显示多久
const _loadingDisplayMinTime = const Duration(milliseconds: 1200);

class _CommonFutureBuilderState extends State<CommonFutureBuilder> {
  DateTime loadingStart;

  @override
  void didUpdateWidget(CommonFutureBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadingStart = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final interval = DateTime.now().millisecondsSinceEpoch -
                loadingStart.millisecondsSinceEpoch;
            if (interval > _loadingDisplayedDelayedMilliseconds) {
              return LazyWidget(
                holderBuilder: (context) =>
                    widget.loadingWidget ?? LoadingIndicator(),
                contentBuilder: (context) => showResult(snapshot, context),
                delay: _loadingDisplayMinTime,
              );
            } else {
              return showResult(snapshot, context);
            }
          } else if (snapshot.hasError) {
            return widget.errorWidget ??
                RequestFailedWidget(
                  description: snapshot.error.toString(),
                );
          } else {
            loadingStart = DateTime.now();
            return LazyWidget(
              holderBuilder: (context) => Container(),
              contentBuilder: (context) =>
                  widget.loadingWidget ?? LoadingIndicator(),
              delay: _loadingDelayedTime,
            );
          }
        });
  }

  Widget showResult(AsyncSnapshot snapshot, BuildContext context) {
    final ApiResult apiResult = snapshot.data;
    if (apiResult.success()) {
      return widget.builder(context, apiResult.data);
    } else {
      return widget.errorWidget ??
          RequestFailedWidget(
            description: apiResult.message(),
          );
    }
  }
}
