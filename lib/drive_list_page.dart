import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Api.dart';
import 'Cell.dart';
import 'dart:convert';

import 'dir_ist_page.dart';
import 'drive_model.dart';

class DriveList extends StatefulWidget {
  const DriveList({Key? key}) : super(key: key);
  @override
  State<DriveList> createState() => _DriveListState();
}

class _DriveListState extends State<DriveList> {
  List<DriveModel> driveList = [];
  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    var httpClient = HttpClient();
    var uri = Uri.parse(Api.domain + Api.driveList);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      var list = data['data']['driveList'];
      List<DriveModel> dataList = [];
      for (var element in list) {
        dataList.add(DriveModel.fromJson(element));
      }
      setState(() {
        driveList = dataList;
      });
    } else {
      if (kDebugMode) {
        print('Error getting IP address:\nHttp status ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('磁盘'),
      ),
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () {
                _get();
                return Future.delayed(const Duration(seconds:1));
              },
              child: ListView.builder(
                  itemCount: driveList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _getRow(index);
                  })
          )
    ),
    );
  }

  Widget _getRow(int i) {
    DriveModel model = driveList[i];
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Cell(
          img: 'img/drive.png',
          originUrl: '',
          name: model.name,
        ),
      ),
      onTap: () {
        if (kDebugMode) {
          var id = model.id;
          var name = model.name;
          print('id: $id  name: $name');
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DirList(
                        driveModel: model,
                        path: '/',
                      )));
        }
      },
    );
  }
}
