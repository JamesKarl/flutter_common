import 'package:flutter/material.dart';

const _error_message_no_network = "网络连接不可用,请检查网络设置";
const _error_message_no_data = "暂无数据";
const _error_message_failed = "请求失败";

class RequestFailedWidget extends StatelessWidget {
  final String description;

  const RequestFailedWidget({
    Key key,
    this.description = _error_message_no_data,
  }) : super(key: key);

  String get message {
    if (description != null && description.startsWith("SocketException")) {
      return _error_message_no_network;
    }
    return description ?? _error_message_failed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Align(
            alignment: Alignment(0, -0.4),
            child: Image.asset(
              "assets/icons/" + "ico_no_internet.png",
              width: 135,
              height: 135,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Align(
            alignment: Alignment(0, 0),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
            ),
          ),
        ),
      ],
    );
  }
}
