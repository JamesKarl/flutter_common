import 'package:flutter/material.dart';

import '../http/http_configs.dart';

class NavigationItemWidget extends StatelessWidget {
  final String icon;
  final String label;
  final GestureTapCallback onTap;
  final Widget rightWidget;
  final IconData iconData;

  const NavigationItemWidget(
    this.label,
    this.onTap, {
    Key key,
    this.icon,
    this.rightWidget,
    this.iconData,
  })  : assert(label != null),
        assert(onTap != null),
        super(key: key);

  bool get hasPrefix => icon != null || iconData != null;

  @override
  Widget build(BuildContext context) {
    final config = Configs.of(context);
    return ListTile(
      title: Text(label),
      leading: buildLeadingWidget(config),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }

  Widget buildLeadingWidget(Configs config) {
    if (icon != null)
      return Image.asset("${config.imageRoot}/icon");
    else if (iconData != null)
      return Icon(iconData);
    else
      return null;
  }
}
