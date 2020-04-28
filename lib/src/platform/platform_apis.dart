import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../extentions/string_extentions.dart';

abstract class PlatformApis {
  static const _prefix = "com.myb/apis/";
  static const _platform = const MethodChannel(_prefix);

  static const _getIPAddress = "getIPAddress";
  static const _pickLocalContact = "pickLocalContact";
  static const _checkIfHasNewVersion = "checkIfHasNewVersion";
  static const _upgradeApp = "upgradeApp";

  PlatformApis._();

  ///拨打电话
  static Future<bool> makeCall(String mobile) async {
    return _phoneRequest(mobile, "tel");
  }

  ///发短信
  static Future<bool> sendSms(String mobile) async {
    return _phoneRequest(mobile, "sms");
  }

  static Future<bool> _phoneRequest(String mobile, String schema) async {
    if (!mobile.isMobile()) {
      return false;
    }
    final url = "$schema:$mobile";
    if (await canLaunch(url)) {
      return launch(url);
    } else {
      return false;
    }
  }

  static Future<String> getIpAddress() async {
    try {
      return _platform.invokeMethod(_getIPAddress);
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  ///返回从手机通讯录选择的联系人。 例如： 张三，13489898989. 以逗号作为分隔符。 选择失败返回null.
  static Future<String> pickLocalContact() async {
    try {
      final String result = await _platform.invokeMethod(_pickLocalContact);
      return result;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  static Future<String> getImageCacheDir() async {
    final doc = await getApplicationDocumentsDirectory();
    final images = Directory("${doc.path}/images/");
    if (!(await images.exists())) {
      images.create(recursive: true);
    }
    return images.path;
  }

  static Future cleanImageCache() async {
    return getImageCacheDir().then((imageRoot) {
      final dir = Directory(imageRoot);
      dir.exists()?.then((value) {
        if (value == true) {
          dir.delete(recursive: true);
        }
      });
    });
  }

  ///检查是否有新版本
  static Future<String> checkIfHasNewVersion() async {
    try {
      return _platform.invokeMethod(_checkIfHasNewVersion);
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  ///如果有新版本就显示提示框，提示用户升级。
  static Future<void> upgradeApp() async {
    try {
      return _platform.invokeMethod(_upgradeApp);
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  static Future launchUrl(String url) async {
    if (url != null && url.startsWith("http") && await canLaunch(url)) {
      await launch(url);
    }
  }
}
