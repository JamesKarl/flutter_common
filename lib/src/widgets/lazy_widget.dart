import 'package:flutter/material.dart';

class LazyWidget extends StatelessWidget {
  final WidgetBuilder holderBuilder;
  final WidgetBuilder contentBuilder;
  final Duration delay;

  const LazyWidget({
    Key key,
    @required this.holderBuilder,
    @required this.contentBuilder,
    this.delay = const Duration(milliseconds: 100),
  })  : assert(holderBuilder != null),
        assert(contentBuilder != null),
        assert(delay != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay, () => true),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Builder(builder: contentBuilder);
        } else {
          return Builder(builder: holderBuilder);
        }
      },
    );
  }
}
