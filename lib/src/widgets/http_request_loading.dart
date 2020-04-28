import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CupertinoActivityIndicator());
  }
}

class LoadingWidget extends StatelessWidget {
  final String loadingText;

  const LoadingWidget({
    Key key,
    this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24),
            CupertinoActivityIndicator(radius: 18),
            SizedBox(height: 12),
            Text(loadingText ?? "正在加载...",
                style: TextStyle(color: const Color(0xFF999999))),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
