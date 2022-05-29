/// id : 3
/// name : "演示 A 盘"
/// enableCache : true
/// autoRefreshCache : false
/// type : {"key":"upyun","description":"又拍云 USS"}
/// searchEnable : false
/// searchIgnoreCase : false
/// searchContainEncryptedFile : false

class DriveModel {
  DriveModel({
    int? id,
    String? name,
    bool? enableCache,
    bool? autoRefreshCache,
    DriveType? type,
    bool? searchEnable,
    bool? searchIgnoreCase,
    bool? searchContainEncryptedFile,
  }) {
    _id = id;
    _name = name;
    _enableCache = enableCache;
    _autoRefreshCache = autoRefreshCache;
    _type = type;
    _searchEnable = searchEnable;
    _searchIgnoreCase = searchIgnoreCase;
    _searchContainEncryptedFile = searchContainEncryptedFile;
  }

  DriveModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _enableCache = json['enableCache'];
    _autoRefreshCache = json['autoRefreshCache'];
    _type = json['type'] != null ? DriveType.fromJson(json['type']) : null;
    _searchEnable = json['searchEnable'];
    _searchIgnoreCase = json['searchIgnoreCase'];
    _searchContainEncryptedFile = json['searchContainEncryptedFile'];
  }
  int? _id;
  String? _name;
  bool? _enableCache;
  bool? _autoRefreshCache;
  DriveType? _type;
  bool? _searchEnable;
  bool? _searchIgnoreCase;
  bool? _searchContainEncryptedFile;
  DriveModel copyWith({
    int? id,
    String? name,
    bool? enableCache,
    bool? autoRefreshCache,
    DriveType? type,
    bool? searchEnable,
    bool? searchIgnoreCase,
    bool? searchContainEncryptedFile,
  }) =>
      DriveModel(
        id: id ?? _id,
        name: name ?? _name,
        enableCache: enableCache ?? _enableCache,
        autoRefreshCache: autoRefreshCache ?? _autoRefreshCache,
        type: type ?? _type,
        searchEnable: searchEnable ?? _searchEnable,
        searchIgnoreCase: searchIgnoreCase ?? _searchIgnoreCase,
        searchContainEncryptedFile:
            searchContainEncryptedFile ?? _searchContainEncryptedFile,
      );
  int? get id => _id;
  String? get name => _name;
  bool? get enableCache => _enableCache;
  bool? get autoRefreshCache => _autoRefreshCache;
  DriveType? get type => _type;
  bool? get searchEnable => _searchEnable;
  bool? get searchIgnoreCase => _searchIgnoreCase;
  bool? get searchContainEncryptedFile => _searchContainEncryptedFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['enableCache'] = _enableCache;
    map['autoRefreshCache'] = _autoRefreshCache;
    if (_type != null) {
      map['type'] = _type?.toJson();
    }
    map['searchEnable'] = _searchEnable;
    map['searchIgnoreCase'] = _searchIgnoreCase;
    map['searchContainEncryptedFile'] = _searchContainEncryptedFile;
    return map;
  }
}

/// key : "upyun"
/// description : "又拍云 USS"

class DriveType {
  DriveType({
    String? key,
    String? description,
  }) {
    _key = key;
    _description = description;
  }

  DriveType.fromJson(dynamic json) {
    _key = json['key'];
    _description = json['description'];
  }
  String? _key;
  String? _description;
  DriveType copyWith({
    String? key,
    String? description,
  }) =>
      DriveType(
        key: key ?? _key,
        description: description ?? _description,
      );
  String? get key => _key;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['description'] = _description;
    return map;
  }
}
