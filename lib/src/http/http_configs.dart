import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Configs extends ChangeNotifier {
  final bool isDebug;
  final bool targetWeb;

  final bool useProductionUrl;
  final bool usePreProductionUrl;
  final bool useTestUrl;

  final String imageRoot;

  final String fakeDataRoot;

  Configs({
    this.targetWeb = false,
    this.isDebug = true,
    this.useProductionUrl = false,
    this.usePreProductionUrl = false,
    this.useTestUrl = true,
    this.imageRoot = "assets/icons",
    this.fakeDataRoot = "http://192.168.11.156:9090/apis/",
  });

  String get httpRoot => useProductionUrl
      ? "https://api.meiyibao.com/mini/"
      : (usePreProductionUrl
          ? "https://prestore.meiyibao.com/mini/"
          : (useTestUrl
              ? "https://teststore.meiyibao.com/mini/"
              : "http://192.168.11.101:9000/mini/"));

  String get h5Root => useProductionUrl
      ? "https://store.meiyibao.com/"
      : (usePreProductionUrl
          ? "https://prestore.meiyibao.com/"
          : (useTestUrl
              ? "https://teststore.meiyibao.com/"
              : "http://192.168.11.101:5566/"));

  String get appAboutUrl => "${h5Root}dataCollectApp/index.html?#/aboutUs";

  bool isProductionEnvironment() =>
      useProductionUrl == true && isDebug == false;

  bool isPreEnvironment() =>
      useProductionUrl == false && usePreProductionUrl == true;

  bool isTestEnvironment() =>
      useProductionUrl == false &&
      usePreProductionUrl == false &&
      useTestUrl == true;

  String getVersionPrefix() {
    if (useProductionUrl) {
      return isDebug ? "product-" : "";
    } else if (usePreProductionUrl) {
      return "pre-";
    } else if (useTestUrl) {
      return "test-";
    } else {
      return "dev-";
    }
  }

  static Configs of(BuildContext context) => Provider.of<Configs>(
        context,
        listen: false,
      );
}
