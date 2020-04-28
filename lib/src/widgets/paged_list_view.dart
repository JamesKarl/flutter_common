import 'package:flutter/material.dart';

import '../ui.dart';
import 'http_request_empty.dart';
import 'lazy_widget.dart';
import '../widgets/http_request_failed.dart';

class PullRefreshNotification extends Notification {}

class RemoveMeNotification<T> extends Notification {
  final T item;

  RemoveMeNotification(this.item);
}

class PageData<T> {
  final bool success;
  final int total;
  final List<T> items;
  final String message;

  const PageData._(this.success, this.total, this.items, this.message);

  const PageData.success(int total, List<T> items)
      : this._(true, total, items, null);

  const PageData.failed(String message) : this._(false, -1, null, message);
}

typedef PageBuilder<T> = Future<PageData<T>> Function(int page, int rows);

/// Signature for a function that creates a widget for a given item of type 'T'.
typedef ItemWidgetBuilder<T> = Widget Function(int index, T item);

/// A scrollable list which implements pagination.
///
/// When scrolled to the end of the list [Pagination] calls [pageBuilder] which
/// must be implemented which returns a Future List of type 'T'.
///
/// [itemBuilder] creates widget instances on demand.
class PagedListView<T> extends StatefulWidget {
  /// Creates a scrollable, paginated, linear array of widgets.
  ///
  /// The arguments [pageBuilder], [itemBuilder] must not be null.
  PagedListView({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.rows = 20,
    this.scrollDirection = Axis.vertical,
    this.progress,
    this.onError,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.semanticChildCount,
    this.noDataWidget,
    this.header,
    this.supportPullRefresh = true,
  })  : assert(pageBuilder != null),
        assert(itemBuilder != null),
        assert(rows > 1),
        super(key: key);

  /// Called when the list scrolls to an end
  ///
  /// Function should return Future List of type 'T'
  final PageBuilder<T> pageBuilder;

  /// Called to build children for [Pagination]
  ///
  /// Function should return a widget
  final ItemWidgetBuilder<T> itemBuilder;

  /// Scroll direction of list view
  final Axis scrollDirection;

  /// When non-null [progress] widget is called to show loading progress
  final Widget progress;

  /// Handle error returned by the Future implemented in [pageBuilder]
  final Function(dynamic error) onError;

  /// rows per page.
  final int rows;

  final Widget noDataWidget;

  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap = false;
  final EdgeInsetsGeometry padding;
  final double itemExtent;
  final bool addAutomaticKeepAlives = true;
  final bool addRepaintBoundaries = true;
  final bool addSemanticIndexes = true;
  final double cacheExtent;
  final int semanticChildCount;
  final supportPullRefresh;

  final Widget header;

  @override
  PagedListViewState<T> createState() => PagedListViewState<T>();
}

class PagedListViewState<T> extends State<PagedListView<T>> {
  final List<T> _list = List();
  bool _isLoading = false;
  bool _isEndOfList = false;

  int _totalCount = -1;

  bool get hasNoData => _list.isEmpty && _isEndOfList;

  bool get hasError => _errorMessage != null && _list.isEmpty;
  String _errorMessage;

  List<T> get dataList => _list;

  void remove(T item) {
    if (_list?.remove(item) == true) {
      setState(() {});
    }
  }

  Future fetchMore() {
    if (!_isLoading) {
      _isLoading = true;
      return widget.pageBuilder(_getPage(), widget.rows).then((pageData) {
        _isLoading = false;
        if (pageData != null && pageData.success) {
          _totalCount = pageData.total;
          if (pageData.items.isEmpty) {
            if (mounted) {
              setState(() {
                _isEndOfList = true;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                if (pageData.items.length < widget.rows) {
                  _isEndOfList = true;
                }
                _list.addAll(pageData.items);
              });
            }
          }
        } else {
          if (mounted) {
            setState(() {
              _errorMessage = pageData?.message ?? "请求失败";
            });
          }
          debugPrint("pageData: $pageData");
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _isEndOfList = true;
          });
        }
        debugPrint(error.toString());
        if (widget.onError != null) {
          widget.onError(error);
        }
      });
    }
    return Future.value(null);
  }

  int _getPage() {
    if (_totalCount < 0) {
      return 1;
    }

    return _list.length ~/ widget.rows + 1;
  }

  @override
  void initState() {
    super.initState();
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return RequestFailedWidget(description: _errorMessage);
    }
    if (widget.supportPullRefresh == false) {
      return hasNoData ? _buildNoDataView(context) : buildListView();
    }
    return NotificationListener(
      child: RefreshIndicator(
        child: hasNoData ? _buildNoDataView(context) : buildListView(),
        onRefresh: () async {
          dataList.clear();
          _totalCount = -1;
          await fetchMore();
          PullRefreshNotification().dispatch(context);
        },
      ),
      onNotification: (notification) {
        if (notification is RemoveMeNotification) {
          final item = notification.item;
          if (item is T) {
            remove(notification.item);
            return true;
          }
        }
        return false;
      },
    );
  }

  ListView buildListView() {
    return ListView.builder(
      padding: widget.padding,
      controller: widget.controller,
      physics: widget.physics,
      primary: widget.primary,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (context, position) {
        int newPosition = widget.header == null ? position : position - 1;
        if (position == 0 && widget.header != null) {
          return widget.header;
        } else if (newPosition < _list.length) {
          return widget.itemBuilder(newPosition, _list[newPosition]);
        } else if (newPosition == _list.length) {
          if (_isEndOfList) {
            if (hasNoData) {
              setState(() {});
            }
            return lastPromptWidget();
          } else {
            fetchMore();
            return LazyWidget(
              holderBuilder: (context) => Container(),
              contentBuilder: (context) => widget.progress ?? Ui.defaultLoading,
            );
          }
        }
        return null;
      },
    );
  }

  Align lastPromptWidget() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
        child: Text("我也是有底线的~~", style: Ui.promptTextStyle),
      ),
    );
  }

  Widget _buildNoDataView(BuildContext context) {
    Widget noData = widget.noDataWidget ?? NoDataWidget();
    if (widget.header != null) {
      return ListView(
        children: <Widget>[
          widget.header,
          noData,
        ],
      );
    }
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child: noData,
        ),
      ],
    );
  }
}
