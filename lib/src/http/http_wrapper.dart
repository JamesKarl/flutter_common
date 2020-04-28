import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'http_configs.dart';


abstract class ApiContext {
  String get httpRoot;

  Configs get configs;

  String get token;
}

extension ApiContextExtention on ApiContext {
  /// common header for all request.
  Map<String, String> _createHeader({
    bool contentTypeJson: true,
    String token,
  }) {
    return {
      "Device": "Android",
      //todo
      "osType": "1",
      "version": "1.0.0",
      //todo
//      "Content-Type":
//          contentTypeJson ? ContentTypeConstant.json : ContentTypeConstant.xml,
      "token": token
    };
  }

  Future<ApiRequestResult> post(
    String url, {
    Map<String, dynamic> params,
    String body,
    String dataKey,
    bool fakeData = false,
    bool fullUrl = false,
    bool decodeWithUtf8 = false,
  }) async {
    String finalUrl =
        fakeData ? "${configs.fakeDataRoot}$url.json" : "$httpRoot$url";
    if (fullUrl == true) {
      finalUrl = url;
    }
    final headers = _createHeader(contentTypeJson: body != null, token: token);

    final Map<String, String> finalParams = {};
    params?.forEach((k, v) {
      if (v != null) {
        finalParams[k] = v.toString();
      }
    });

    if (configs.isDebug) {
      print(finalUrl);
      print(headers);

      if (finalParams.isNotEmpty) {
        debugPrint("params: $finalParams");
      }

      if (body != null) {
        debugPrint("body: $body");
      }

      _printCurlLog(body, finalParams, headers, finalUrl);
    }

    http.Response response;
    try {
      final now = DateTime.now();
      if (fakeData) {
        response = await http.get(finalUrl);
      } else {
        response = await http.post(finalUrl,
            headers: headers,
            body: body != null
                ? body
                : (finalParams.isNotEmpty ? finalParams : null));
      }

      String bodyString = decodeWithUtf8 == true
          ? Encoding.getByName("utf-8").decode(response.bodyBytes)
          : response.body;

      final result = ApiRequestResult(
        body: bodyString,
        httpCode: response.statusCode,
        dataKey: dataKey,
        bodyAsData: fullUrl, //第三方接口
      );

      if (configs.isDebug) {
        print(finalUrl +
            " (${DateTime.now().millisecondsSinceEpoch - now.millisecondsSinceEpoch}ms)");
        print(result);
      }
      if (!result.success()) {
        _interceptException(result);
      }
      return result;
    } catch (t, s) {
      if (configs.isDebug) {
        print(t);
        print(s);
      }

      final result = ApiRequestResult(
          body: response?.body ?? "", httpCode: response?.statusCode ?? -1);

      if (t is SocketException) {
        result.message = t.toString();
      }

      return result;
    }
  }

  void _printCurlLog(String body, Map<String, dynamic> params,
      Map<String, String> headers, String url) {
    final sb = StringBuffer();
    sb.write(" curl -i -X POST ");
    sb.write('-H "Accept-Encoding:compress;q=0.5, gzip;q=1.0" ');

    if (params != null && params.isNotEmpty) {
      final pb = StringBuffer();
      params.forEach((k, v) {
        pb.write("$k=$v&");
      });
      pb.write("xxx=xxx");
      sb.write(" -d \"${pb.toString()}\" ");
    }

    if (body != null) {
      sb.write(" -d $body ");
    }

    if (headers != null && headers.isNotEmpty) {
      headers.forEach((k, v) {
        sb.write("-H \"$k:$v\" ");
      });
    }

    sb.write(url);

    print(sb.toString());
  }

  void _interceptException(ApiRequestResult result) {
    if (result.code == HttpExceptionCode.tokenExpired) {
      //authenticationBloc.add(LoggedOut()); todo how to logout ?
    }
  }

  ///图片文件上传
  Future<ApiRequestResult> uploadImageFile(
    String url,
    File file, {
    Map<String, dynamic> params,
    String dataKey,
  }) async {
    var name = file.path;
    if (name.contains("/")) {
      name = name.substring(name.lastIndexOf("/") + 1);
    }
    return _uploadImage(
      url,
      name,
      await file.readAsBytes(),
      params: params,
      dataKey: dataKey,
    );
  }

  Future<ApiRequestResult> _uploadImage(
      String url, String name, List<int> bytes,
      {Map<String, dynamic> params, String dataKey}) async {
    final String finalUrl = url.startsWith("http") ? url : (httpRoot + url);
    // string to uri
    Uri uri = Uri.parse('$finalUrl');
    final headers = _createHeader(contentTypeJson: false);
// create multipart request
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: '$name',
      contentType: MediaType("image", "jpg"),
    );
    params?.forEach((key, value) {
      request.fields[key] = '$value';
    });

    http.StreamedResponse response;
    try {
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      response = await request.send();
      String responseBody = await response.stream.bytesToString();
      debugPrint('upload respones lo $responseBody');
      final result = ApiRequestResult(
          body: responseBody, httpCode: response.statusCode, dataKey: dataKey);
      if (configs.isDebug) {
        print(finalUrl);
        print(result);
      }
      if (!result.success()) {
        _interceptException(result);
      }
      return result;
    } catch (t, s) {
      if (configs.isDebug) {
        print(t);
        print(s);
      }
      return ApiRequestResult(body: "", httpCode: response?.statusCode ?? -1);
    }
  }
}

abstract class ContentTypeConstant {
  static final String json = "application/json";
  static final String xml = "application/xml";
  static final String formUrlEncoded = "application/x-www-form-urlencoded";
  static String headerContentType = "Content-Type";
}

abstract class HttpExceptionCode {
  static final authParamInvalid = 1001; //参数不全
  static final authExpired = 1002; //授权过期
  static final tokenExpired = 10005; //TOKEN失效
  static final accountLocked = 90000; //账号已经冻结
  static final accountNotExist = 20000; //账号不存在

  static final timeout = 20100; //请求超时
  static final noNetwork = 20101; //没有网络
}

class ApiRequestResult {
  final String body;
  final int httpCode;
  int code;
  String message;
  String _status;
  dynamic data;
  final String dataKey;
  final bodyAsData;

  var _parseDataSuccess = true;

  ApiRequestResult({
    this.body,
    this.httpCode,
    this.dataKey,
    this.bodyAsData = false,
  }) {
    if (httpCode == 200 && body != null) {
      if (bodyAsData == true) {
        final Map<String, dynamic> result = jsonDecode(body);
        if (dataKey?.isNotEmpty ?? false) {
          data = result[dataKey];
        } else {
          data = result;
        }
        _parseDataSuccess = true;
        _status = "success";
      } else {
        try {
          final Map<String, dynamic> result = jsonDecode(body);
          code = result["code"];
          message = result["message"];
          _status = result["status"];
          if (_status == "success") {
            if (dataKey != null && dataKey.isNotEmpty) {
              data = result["data"][dataKey];
            } else {
              data = result["data"];
            }
          } else {
            data = result["data"];
          }
        } catch (e, s) {
          _parseDataSuccess = false;
          print(s);
        }
      }
    }
  }

  ApiRequestResult.fakeResult() : this(httpCode: 200);

  bool success() =>
      _parseDataSuccess && httpCode == 200 && _status == "success";

  @override
  String toString() {
    return "RequestResult:{httpCode: $httpCode, parseDataSuccess: $_parseDataSuccess, status: $_status"
        " code: $code, message: $message, "
        "${(success() && data != null) ? ('\ndata: ' + jsonEncode(data)) : ('\nbody: ' + (body ?? ""))}\n";
  }
}

class ApiResult {
  final ApiRequestResult rawResult;
  final dynamic data;

  const ApiResult({this.rawResult, this.data});

  bool success() =>
      identical(this, ok) || (rawResult != null && rawResult.success());

  int code() => rawResult.code;

  String message() => rawResult?.message ?? "";

  static final ApiResult ok = ApiResult();

  factory ApiResult.fakeResult(int code, String message, {dynamic data}) {
    return ApiResult(
        rawResult: ApiRequestResult.fakeResult()
          ..message = message
          ..code = code,
        data: data);
  }

  @override
  String toString() {
    return 'ApiResult{success: ${success()}, message: ${message()}, rawResult: $rawResult}';
  }
}
