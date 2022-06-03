import 'package:file_preview/file_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dir_model.dart';

class FilePreviewPage extends StatefulWidget {
  final DirModel model;
  const FilePreviewPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  FilePreviewPageState createState() => FilePreviewPageState();
}

class FilePreviewPageState extends State<FilePreviewPage> {
  bool isInit = false;

  @override
  initState() {
    super.initState();
    _initTBS();
  }

  void _initTBS() async {
    isInit = await FilePreview.initTBS();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.name!),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: isInit
            ? FilePreviewWidget(
                width: width, //宽
                height: height, //高
                path: widget.model.url ?? '',
                callBack: FilePreviewCallBack(onShow: () {
                  if (kDebugMode) {
                    print("文件打开成功");
                  }
                }, onDownload: (progress) {
                  if (kDebugMode) {
                    print("文件下载进度$progress");
                  }
                }, onFail: (code, msg) {
                  if (kDebugMode) {
                    print("文件打开失败 $code  $msg");
                  }
                }), //file path or http url
              )
            : Container(),
      ),
    );
  }
}
