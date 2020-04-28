import 'dart:io';

///"baseUrl": "temp/43234324.jpg",
///"visitUrl": "https://test-store-bucket.oss-cn-hangzhou.aliyuncs.com/20190301/43234324.jpg"
class FileUploadBean {
  String relativePath;
  String url;
  String localPath;

  FileUploadBean({
    this.relativePath,
    this.url,
    this.localPath,
  });

  FileUploadBean.fromUrl(String url) {
    this.url = url;
  }

  FileUploadBean.fromFile(File file) {
    this.localPath = file.path;
  }

  FileUploadBean.fromPath(String filePath) {
    this.localPath = filePath;
  }

  FileUploadBean.fromJson(Map<String, dynamic> json) {
    this.relativePath = json['baseUrl'];
    this.url = json['visitUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseUrl'] = this.relativePath;
    data['visitUrl'] = this.url;
    return data;
  }

  bool get hasLocalCache =>
      localPath != null && localPath.isNotEmpty && File(localPath).existsSync();

  bool get hasUrl => url?.startsWith("http") ?? false;

  bool get isEmpty => (url?.isEmpty ?? true) && (localPath?.isEmpty ?? true);

  void clear() {
    relativePath = null;
    url = null;
    localPath = null;
  }

  @override
  String toString() {
    return 'ApiFileUploadBean{baseUrl: $relativePath, visitUrl: $url}';
  }
}
