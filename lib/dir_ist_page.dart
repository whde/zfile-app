import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zfile/cell_video.dart';
import 'package:zfile/file_preview.dart';
import 'package:zfile/file_type.dart';
import 'package:zfile/photo_preview.dart';
import 'video_preview.dart';
import 'Api.dart';
import 'drive_model.dart';
import 'Cell.dart';
import 'dart:convert';
import 'dir_model.dart';
import 'file_tools.dart';

class DirList extends StatefulWidget {
  const DirList({Key? key, required this.driveModel, required this.path})
      : super(key: key);

  final DriveModel driveModel;
  final String path;
  @override
  State<DirList> createState() => _DirListState();
}

class _DirListState extends State<DirList> {
  List<DirModel> fileList = [];
  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    var httpClient = HttpClient();
    var uri = Uri.parse(
        '${Api.domain}${Api.fileList}${widget.driveModel.id}?path=${Uri.encodeComponent(widget.path)}');
    if (kDebugMode) {
      print('Http: $uri');
    }
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      var list = data['data']['files'];
      List<DirModel> dataList = [];
      for (var element in list) {
        if (element['name'].indexOf(FileTools.tmpDirName) != -1) {
          continue;
        }
        dataList.add(DirModel.fromJson(element));
      }
      setState(() {
        fileList = dataList;
      });
    } else {
      if (kDebugMode) {
        print('Error getting IP address:\nHttp status ${response.statusCode}');
      }
    }
  }

  String _driveName() {
    return widget.driveModel.name ?? '';
  }

  String _title() {
    var name = widget.path.length > 1 ? widget.path : _driveName();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(_title()),
        ),
        body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () {
                _get();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                  itemCount: fileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _getRow(index);
                  })),
        ));
  }

  Widget _getRow(int i) {
    DirModel model = fileList[i];
    FileType type = model.getFileType();
    String? img = _fileListImage(type, model) ?? '';
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: _cell(img, model),
      ),
      onTap: () {
        _cellOnTap(model, type);
      },
    );
  }

  Widget _cell(String img, DirModel model) {
    switch (model.getFileType()) {
      case FileType.video:
        return _videoCell(img, model);
      default:
        return _universalCell(img, model);
    }
  }

  Cell _universalCell(String img, DirModel model) {
    return Cell(
        img: img,
        originUrl: model.url ?? '',
        name: model.name,
      );
  }

  VideoCell _videoCell(String img, DirModel model) {
    return VideoCell(
      img: img,
      originUrl: model.url ?? '',
      name: model.name,
    );
  }

  void _cellOnTap(DirModel model, FileType type) {
    var name = model.name ?? '';
    var path = model.path ?? '';
    if (kDebugMode) {
      print('name: $path$name');
    }
    switch (type) {
      case FileType.folder:
        _toFolder(path, name);
        break;
      case FileType.image:
        _toImages(model);
        break;
      case FileType.video:
        _toVideo(model);
        break;
      case FileType.docFile:
        _toFile(model);
        break;
      case FileType.unknown:
        // TODO: Handle this case.
        break;
    }
  }

  String? _fileListImage(FileType type, DirModel model) {
    switch (type) {
      case FileType.video:
        return 'img/video.png';
      case FileType.image:
        return model.url?.thumbnailUrl() ?? '';
      default:
        String url = 'floder';
        if (!(type == FileType.folder)) {
          url = model.url ?? '';
        }
        return url.fileICON();
    }
  }

  void _toFile(DirModel model) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => FilePreviewPage(model: model)));
  }

  void _toVideo(DirModel model) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => VideoPreview(model: model)));
  }

  void _toImages(DirModel model) {
    List<DirModel> list = [];
    int index = 0;
    for (var element in fileList) {
      if (!(element.url ?? '').isImgFile()) {
        continue;
      }
      if (element == model) {
        index = list.length;
      }
      list.add(element);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PhotoPreview(
                  galleryItems: list,
                  defaultImage: index,
                )));
  }

  void _toFolder(String path, String name) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => DirList(
                  driveModel: widget.driveModel,
                  path: path + name,
                )));
  }
}
