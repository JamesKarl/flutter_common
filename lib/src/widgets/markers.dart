import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.location_on,
      color: Theme.of(context).primaryColor,
    );
  }
}

class InfoIcon extends StatelessWidget {
  final double size;

  const InfoIcon({Key key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.info,
      color: Theme.of(context).primaryColor,
      size: size ?? 24,
    );
  }
}
