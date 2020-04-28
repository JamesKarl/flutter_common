import 'package:flutter/material.dart';
import 'package:fluttercommon/src/http/http_wrapper.dart';

import '../extentions/string_extentions.dart';

typedef Future<ApiResult> SmsMessenger(String mobile);

class SendSmsWidget extends StatefulWidget {
  final ValueNotifier<String> mobileNotifier;
  final SmsMessenger smsMessenger;

  const SendSmsWidget({
    Key key,
    @required this.mobileNotifier,
    @required this.smsMessenger,
  })  : assert(smsMessenger != null),
        super(key: key);

  @override
  _SendSmsWidgetState createState() => _SendSmsWidgetState();
}

class _SendSmsWidgetState extends State<SendSmsWidget> {
  bool hasSentSms = false;
  final smsWaitSeconds = 60;
  int counter = 0;
  bool sendingSmsCode = false;

  String get mobile => widget.mobileNotifier.value;

  bool get canSendSmsCode => (mobile?.isMobile() ?? false) && !sendingSmsCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ValueListenableBuilder(
        valueListenable: widget.mobileNotifier,
        builder: (BuildContext context, String value, Widget child) {
          final color = canSendSmsCode ? Colors.orange : Colors.grey;
          return FlatButton(
            child: Text(
              sendingSmsCode ? "获取验证码(${counter}s)" : "获取验证码",
              style: TextStyle(
                fontSize: 13,
                color: color,
              ),
            ),
            onPressed: canSendSmsCode ? sendSmsCode : null,
          );
        },
      ),
    );
  }

  void sendSmsCode() {
    widget.smsMessenger(mobile).then((result) {
      print("xxxxxx ${result.data}");
      if (result != null && result.success()) {
        updateTimer();
      } else {
        //showAlert(context, result?.message() ?? "请求失败");
      }
    });
  }

  Future updateTimer() async {
    counter = smsWaitSeconds;
    if (mounted) {
      setState(() {
        sendingSmsCode = true;
      });
    }
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      counter--;
      if (mounted) {
        setState(() {});
      }
      debugPrint("counter: $counter");
      return counter > 0 && mounted;
    }).whenComplete(() {
      counter = 0;
      sendingSmsCode = false;
      if (mounted) {
        setState(() {});
      }
    });
  }
}
