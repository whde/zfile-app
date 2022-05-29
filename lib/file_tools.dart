class FileTools {
  static List<String> imgExtList = [
    'bmp',
    'jpg',
    'png',
    'tif',
    'gif',
    'pcx',
    'tga',
    'exif',
    'fpx',
    'svg',
    'psd',
    'cdr',
    'pcd',
    'dxf',
    'ufo',
    'eps',
    'ai',
    'raw',
    'WMF',
    'webp',
    'avif',
    'apng'
  ];

  static List<String> videoExtList = [
    'mpeg',
    'avi',
    'navi',
    'asf',
    'mov',
    '3gp',
    'wmv',
    'divx',
    'xvid',
    'rm',
    'rmvb',
    'mpg',
    'flv',
    'f4v',
    'mp4'
  ];

  static Map<String, String> fileExtMap = {
    'apk': 'img/apk.png',
    'dmg': 'img/dmg.png',
    'eddx': 'img/eddx.png',
    'xls': 'img/file_excel.png',
    'xlsx': 'img/file_excel.png',
    'floder': 'img/file_floder.png',
    'pdf': 'img/file_pdf.png',
    'ppt': 'img/file_ppt.png',
    'qita': 'img/file_qita.png',
    'txt': 'img/file_txt.png',
    'word': 'img/file_word.png',
    'ipa': 'img/ipa.png',
    'ipsw': 'img/ipsw.png',
    'iso': 'img/iso.png',
    'keynote': 'img/keynote.png',
    'music': 'img/music.png',
    'numbers': 'img/numbers.png',
    'pages': 'img/pages.png',
    'pkg': 'img/pkg.png',
    'rar': 'img/rar.png',
    'video': 'img/video.png',
    'xip': 'img/xip.png',
    'zip': 'img/zip.png'
  };
  static String defaultFileExtImg = 'img/file_webView_error.png';
  static String tmpDirName = 'whde_tmp';
}

extension ZFile on String {
  String ext() {
    return split('/').last.split('.').last;
  }

  bool isImgFile() {
    return FileTools.imgExtList.contains(ext().toLowerCase());
  }

  String thumbnailUrl() {
    var list = split('/');
    var name = list.last;
    var path = replaceAll(name, '${FileTools.tmpDirName}/$name');
    return path;
  }

  bool isVideoFile() {
    return FileTools.videoExtList.contains(ext().toLowerCase());
  }

  String fileICON() {
    return FileTools.fileExtMap[ext().toLowerCase()] ??
        FileTools.defaultFileExtImg;
  }
}
