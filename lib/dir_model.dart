/// name : "iPhone_20190903_235103.vcf"
/// time : "2019-09-03 23:51"
/// size : 456008
/// type : "FILE"
/// path : "/老妈手机/"
/// url : "http://172.30.145.177:8080/file/1/老妈手机/iPhone_20190903_235103.vcf"

class DirModel {
  DirModel({
    String? name,
    String? time,
    int? size,
    String? type,
    String? path,
    String? url,
  }) {
    _name = name;
    _time = time;
    _size = size;
    _type = type;
    _path = path;
    _url = url;
  }

  DirModel.fromJson(dynamic json) {
    _name = json['name'];
    _time = json['time'];
    _size = json['size'];
    _type = json['type'];
    _path = json['path'];
    _url = json['url'];
  }
  String? _name;
  String? _time;
  int? _size;
  String? _type;
  String? _path;
  String? _url;
  DirModel copyWith({
    String? name,
    String? time,
    int? size,
    String? type,
    String? path,
    String? url,
  }) =>
      DirModel(
        name: name ?? _name,
        time: time ?? _time,
        size: size ?? _size,
        type: type ?? _type,
        path: path ?? _path,
        url: url ?? _url,
      );
  String? get name => _name;
  String? get time => _time;
  int? get size => _size;
  String? get type => _type;
  String? get path => _path;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['time'] = _time;
    map['size'] = _size;
    map['type'] = _type;
    map['path'] = _path;
    map['url'] = _url;
    return map;
  }
}
