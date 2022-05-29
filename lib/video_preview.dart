import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import 'dir_model.dart';

class VideoPreview extends StatefulWidget {
  final DirModel model;
  const VideoPreview({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  RotationAndFitPageState createState() => RotationAndFitPageState();
}

class RotationAndFitPageState extends State<VideoPreview> {
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      fit: BoxFit.scaleDown,
        expandToFill: true
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.model.url!);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.name!),
      ),
      body: Center(
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }
}
