import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoCell extends StatefulWidget {
  final String img;
  final String originUrl;
  final String? name;
  const VideoCell({
    Key? key,
    required this.img,
    required this.originUrl,
    this.name,
  }) : super(key: key);

  @override
  VideoCellState createState() => VideoCellState();
}

class VideoCellState extends State<VideoCell> {
  File? file;
  Future _genThumbnailFile() async {
    String name = widget.name?.split('.').first ?? '';
    Directory tempDirectory = await getTemporaryDirectory();

    String? thumbnail = '${tempDirectory.path}/$name.jpg';
    File? cacheFile = File(thumbnail);
    if (!cacheFile.existsSync()) {
      thumbnail = await VideoThumbnail.thumbnailFile(
        video: widget.originUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 100,
        quality: 75,
      );
    }
    setState(() {
      if (thumbnail != null) {
        file = File(thumbnail);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _genThumbnailFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 42,
                height: 53,
                child:
                    file != null ? Image.file(file!) : Image.asset(widget.img),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name != null ? widget.name! : "未知磁盘",
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'PingFangSC-Medium',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          const Divider(
            height: 1.0,
            indent: 50.0,
          ),
        ]));
  }
}
