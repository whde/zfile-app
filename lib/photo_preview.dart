import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dir_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  final List<DirModel> galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged? pageChanged; //切换图片回调
  final Axis direction; //图片查看方向

  const PhotoPreview({
    Key? key,
    required this.galleryItems,
    this.defaultImage = 1,
    this.pageChanged,
    this.direction = Axis.horizontal,
  }) : super(key: key);
  @override
  PhotoPreviewState createState() => PhotoPreviewState();
}

class PhotoPreviewState extends State<PhotoPreview> {
  late int tempSelect;
  String name = '';
  @override
  void initState() {
    super.initState();
    tempSelect = widget.defaultImage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      navigationBar: CupertinoNavigationBar(
        middle: Text(name),
      ),
      child: Stack(
        children: [
          PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(
                     widget.galleryItems[index].url!,
                  ),
                );
              },
              scrollDirection: widget.direction,
              itemCount: widget.galleryItems.length,
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              pageController: PageController(initialPage: widget.defaultImage),
              onPageChanged: (index) => setState(() {
                    tempSelect = index + 1;
                    name = widget.galleryItems[index].name!;
                    if (widget.pageChanged != null) {
                      widget.pageChanged!(index);
                    }
                  })),
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              '$tempSelect/${widget.galleryItems.length}',
              style: const TextStyle(color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
