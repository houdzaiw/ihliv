
class UploadResultModel {
  String? filename;
  String? size;
  String? mimeType;
  String? width;
  String? height;

  UploadResultModel(
      {this.filename, this.size, this.mimeType, this.width, this.height});

  UploadResultModel.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    size = json['size'];
    mimeType = json['mimeType'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = filename;
    data['size'] = size;
    data['mimeType'] = mimeType;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
