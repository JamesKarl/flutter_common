import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extentions/string_extentions.dart';

class MakeCallButton extends StatelessWidget {
  final String mobile;

  const MakeCallButton({
    Key key,
    @required this.mobile,
  }) : super(key: key);

  bool get isMobileValid => mobile != null && mobile.isMobile();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isMobileValid
          ? () {
              mobile.makeCall();
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 12,
          child: Icon(Icons.call, size: 14),
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.black.withOpacity(0.7),
        child: Icon(
          Icons.clear,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const ArrowButton({
    Key key,
    @required this.onPressed,
    this.iconData = Icons.keyboard_arrow_right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
