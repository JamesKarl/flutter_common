import 'package:flutter/material.dart';

class FeatureAbsentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("未实现功能"),
      ),
      body: Center(
        child: Text(
          "敬请期待...",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
