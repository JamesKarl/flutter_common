import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttercommon/src/platform/platform_apis.dart';

extension StringExtentions on String {
  String md5String() {
    var content = new Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  bool isMobile() {
    return this.length == 11 && RegExp("[0-9]{11}").hasMatch(this);
  }

  ///判断是否是身份证
  bool isIdentity() {
    return (this.length == 18 && RegExp("[0-9]{18}").hasMatch(this)) ||
        (this.length == 15 && RegExp("[0-9]{15}").hasMatch(this));
  }

  bool isSmsCode({int len = 4}) {
    return this.length == len && RegExp("[0-9]{$len}").hasMatch(this);
  }

  Future<void> launchUrl() => PlatformApis.launchUrl(this);

  Future<bool> makeCall() => PlatformApis.makeCall(this);
}
