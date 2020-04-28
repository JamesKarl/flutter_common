import 'package:flutter/material.dart';

import '../http/http_configs.dart';

class AvatarWidget extends StatelessWidget {
  final String url;
  final double radius;

  const AvatarWidget({
    Key key,
    @required this.url,
    this.radius = 24,
  })  : assert(radius >= 12),
        super(key: key);

  bool get isUrlValid => url?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    final imageRoot = Configs.of(context).imageRoot;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: isUrlValid
            ? FadeInImage.assetNetwork(
                placeholder: "$imageRoot/avatar.png",
                image: url,
                fit: BoxFit.cover,
              )
            : Image.asset(
                "$imageRoot/avatar.png",
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
