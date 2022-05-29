import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    String type = model.type ?? '';
    bool isFolder = (type.compareTo('FOLDER') == 0);
    bool isImg = (model.url ?? '').isImgFile();
    bool isVideo = (model.url ?? '').isVideoFile();
    String? img;
    if (isImg) {
      img = model.url?.thumbnailUrl() ?? '';
    } else if (isVideo) {
      img = 'img/video.png';
    } else {
      String url = 'floder';
      if (!isFolder) {
        url = model.url ?? '';
      }
      img = url.fileICON();
    }
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Cell(
          img: img,
          name: model.name,
        ),
      ),
      onTap: () {
        if (kDebugMode) {
          var name = model.name ?? '';
          var path = model.path ?? '';
          print('name: $path$name');
          if (isFolder) {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => DirList(
                          driveModel: widget.driveModel,
                          path: path + name,
                        )));
          } else if (isImg) {
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
          } else if (isVideo) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => VideoPreview(model: model)));
          }
        }
      },
    );
  }
}
